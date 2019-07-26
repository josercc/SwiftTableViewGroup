//
//  ViewController.swift
//  SwiftTableViewGroupApp
//
//  Created by 张行 on 2019/7/17.
//  Copyright © 2019 张行. All rights reserved.
//

import UIKit
import SwiftTableViewGroup

class MyCustomCell: UITableViewCell {
    var name = "Hello Word"
}

class ViewController: UIViewController {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.scrollDelegate?.scrollViewDidScroll = { scrollView in
            
        }
        return tableView
    }()
    
    lazy var dataSource:TableView = {
        TableView(tableView: self.tableView)
    }()
    
    let source:[String] = [
        "普通的列表文本",
        "复杂的设置界面",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example"
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.steupTableView()
        
    }
    
    func steupTableView() {
        self.dataSource.setup {
            TableCell { (tableCell, blockType, cell, index) in
                tableCell.makeContentBlock(type: blockType,
                                           cell: cell,
                                           index: index,
                                           configContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                            cell.textLabel?.text = self.source[index]
                                            cell.accessoryType = .disclosureIndicator
                    },
                                           didSelectRowContent: self.didSelectRowContent())
            }
            .number(self.source.count)
            .height(45)
        }
        self.dataSource.reloadData()
    }
    
    func didSelectRowContent() -> CellBlockContent<UITableViewCell> {
        CellBlockContent<UITableViewCell> {(cell,index) in
            let detail = DetailViewController()
            detail.title = self.source[index]
            if index == 0 {
                detail.dataSource = self.setupNormalList(tableView: detail.tableView)
            } else if index == 1 {
                detail.dataSource = self.setupCustomList(tableView: detail.tableView)
            }
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    
    //MARK: - 普通的列表界面
    func setupNormalList(tableView:UITableView) -> TableView {
        var normalDataSource = TableView(tableView: tableView)
        let number = arc4random() % 10 + 2
        normalDataSource.setup {
            TableCell(MyCustomCell.self, { (tableCell, blockType, cell, index) in
                tableCell.makeContentBlock(type: blockType, cell: cell, index: index, configContent: CellBlockContent<MyCustomCell> {(cell, index) in
                    cell.textLabel?.text = "\(index) \(cell.name)"
                })
            })
            .number(Int(number))
            .height(45)
        }
        return normalDataSource
    }
    
    //MARK: - 复杂的设置界面
    func setupCustomList(tableView:UITableView) -> TableView {
        var settingDataSource = TableView(tableView: tableView)
        settingDataSource.setup {
            TableHeaderFooterView(SettingHeaderView.self, .header,{ (tableHeader, header, section) in
                tableHeader.makeContentBlock(headerFooter: header, section: section, configContent: HeaderFooterBlockContent<SettingHeaderView> {(header,section) in
                    header.textLabel?.text = "Header"
                })
            })
            .height(49)
            TableCell(IntrinsicContentTextLabelCell.self)
            TableCell { (tableCell, blockType, cell, index) in
                tableCell.makeContentBlock(type: blockType, cell: cell, index: index, configContent: CellBlockContent<UITableViewCell> {(cell,index) in
                    cell.textLabel?.text = "\(index) 点击我会增加哦"
                    }, didSelectRowContent: CellBlockContent<UITableViewCell> {(cell,index) in
                        let number = tableCell.number + 1
                        tableCell.number(number)
                        settingDataSource.reloadData()
                })
            }
            TableCell { (tableCell, blockType, cell, index) in
                tableCell.makeContentBlock(type: blockType,
                                           cell: cell,
                                           index: index,
                                           configContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                            cell.textLabel?.text = "点击我改变高度"
                    },
                                           didSelectRowContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                            let height = tableCell.height == 44 ? 100 : 44;
                                            tableCell.height(CGFloat(height))
                                            settingDataSource.reloadData()
                })
            }
            .height(44)
        }
        return settingDataSource
    }
    
}

