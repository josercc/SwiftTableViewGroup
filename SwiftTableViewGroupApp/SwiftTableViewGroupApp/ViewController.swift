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
        "Normal Table View",
        "Detail Table View",
        "Normal Collection View"
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
            TableCell { content, contentCell in
                content.configuration(UITableViewCell.self) { (cell, index) in
                    cell.textLabel?.text = self.source[index]
                    cell.accessoryType = .disclosureIndicator
                }
                content.didSelectRow(UITableViewCell.self) { (cell, index) in
                    let detail = DetailViewController()
                    detail.title = self.source[index]
                    if index == 0 {
                        detail.dataSource = self.setupNormalList(tableView: detail.tableView)
                        self.navigationController?.pushViewController(detail, animated: true)
                    } else if index == 1 {
                        detail.dataSource = self.setupCustomList(tableView: detail.tableView)
                        self.navigationController?.pushViewController(detail, animated: true)
                    } else if index == 2 {
                        let controller = NormalCollectionViewController()
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    
                }
            }
            .number(self.source.count)
            .height(45)
        }
        self.dataSource.reloadData()
    }
    //MARK: - 普通的列表界面
    func setupNormalList(tableView:UITableView) -> TableView {
        let normalDataSource = TableView(tableView: tableView)
        let number = arc4random() % 10 + 2
        normalDataSource.setup {
            TableCell(MyCustomCell.self, { content,contentCell in
                content.configuration(MyCustomCell.self) { (cell, index) in
                    cell.textLabel?.text = "\(index) \(cell.name)"
                }
                content.customHeight(MyCustomCell.self) { (cell, index) -> CGFloat in
                    return 100
                }
            })
            .number(Int(number))
            .height(45)
        }
        return normalDataSource
    }
    
    //MARK: - 复杂的设置界面
    func setupCustomList(tableView:UITableView) -> TableView {
        let settingDataSource = TableView(tableView: tableView)
        settingDataSource.setup {
            TableHeaderView(SettingHeaderView.self, { content,contentHeader in
                content.configuration(SettingHeaderView.self) { (view, section) in
                    view.textLabel?.text = "Header"
                }
            })
            .height(49)
            
            TableCell(IntrinsicContentTextLabelCell.self)
            TableCell { content,contentCell in
                content.configuration(UITableViewCell.self) { (cell, index) in
                    cell.textLabel?.text = "\(index) 点击我会增加哦"
                }
                content.didSelectRow(UITableViewCell.self) { (cell, index) in
                    let number = contentCell.number + 1;
                    contentCell.number(number)
                    settingDataSource.reloadData()
                }
            }
            .height(44)
            TableCell { content,contentCell in
                content.configuration(UITableViewCell.self) { (cell, index) in
                    cell.textLabel?.text = "点击我改变高度"
                }
                content.didSelectRow(UITableViewCell.self) { (cell, index) in
                    let height = contentCell.height == 44 ? 100 : 44;
                    contentCell.height(CGFloat(height))
                    settingDataSource.reloadData()
                }
            }
            .height(44)
        }
        return settingDataSource
    }
    
}

