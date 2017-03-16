//
//  ViewController.swift
//  ZHTableViewGroupSwift
//
//  Created by 15038777234 on 03/14/2017.
//  Copyright (c) 2017 15038777234. All rights reserved.
//

import UIKit
import ZHTableViewGroupSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }

    var dataSource:ZHTableViewDataSource?

    var list:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = ZHTableViewDataSource(tableView: self.tableView)
        self.reloadCells()
    }

    func reloadCells() {
        self.dataSource?.clearData()
        self.dataSource?.addGroup(completionHandle: { (group) in
            if self.list.contains("Your Image") {
                group.addCell(completionHandle: { (cell) in
                    registerCellOne(cell: cell)
                })
            }
            if self.list.contains("Your Background") {
                group.addCell(completionHandle: { (cell) in
                    registerCellTwo(cell: cell)
                })
            }
            if self.list.contains("E-mail") {
                group.addCell(completionHandle: { (cell) in
                    registerOtherCell(cell: cell, title: "E-mail", detailTitle: "25867347@qq.com", accessoryType: .none)
                })
            }
            if self.list.contains("Name") {
                group.addCell(completionHandle: { (cell) in
                    registerOtherCell(cell: cell, title: "Name", detailTitle: "Tina", accessoryType: .disclosureIndicator)
                })
            }
            if self.list.contains("Gender") {
                group.addCell(completionHandle: { (cell) in
                    registerOtherCell(cell: cell, title: "Gender", detailTitle: "Female", accessoryType: .disclosureIndicator)
                })
            }
            if self.list.contains("Interest List") {
                group.addCell(completionHandle: { (cell) in
                    registerOtherCell(cell: cell, title: "Interest List", detailTitle: "", accessoryType: .disclosureIndicator)
                })
            }
            if self.list.contains("Blank Cell") {
                group.addCell(completionHandle: { (cell) in
                    registerBlankCell(cell: cell)
                })
            }
            if self.list.contains("Shipping Address Book") {
                group.addCell(completionHandle: { (cell) in
                    registerOtherCell(cell: cell, title: "Shipping Address Book", detailTitle: "", accessoryType: .disclosureIndicator)
                })
            }
        })
        dataSource?.reloadTableViewData()
    }

    func registerCellOne(cell:ZHTableViewCell) {
        setCell(cell: cell, cellNumber: 1, anyClass: ZHCellOneTableViewCell.self, height: 76, identifier: "ZHCellOneTableViewCellIdentifier")
        cell.setConfigCompletionHandle(configCompletionHandle: { (cell, indexPath) in
            guard let cellOne = cell as? ZHCellOneTableViewCell else {
                return
            }
            cellOne.textLabel?.text = "Your Image"
        })
    }

    func registerCellTwo(cell:ZHTableViewCell) {
        setCell(cell: cell, cellNumber: 1, anyClass: ZHCellTwoTableViewCell.self, height: 61, identifier: "ZHCellTwoTableViewCellIdentifier")
        cell.setConfigCompletionHandle(configCompletionHandle: { (cell, indexPath) in
            guard let cellTwo = cell as? ZHCellTwoTableViewCell else {
                return
            }
            cellTwo.textLabel?.text = "Your Background"
        })
    }

    func registerOtherCell(cell:ZHTableViewCell, title:String, detailTitle:String, accessoryType:UITableViewCellAccessoryType) {
        setCell(cell: cell, cellNumber: 1, anyClass: ZHOtherTableViewCell.self, height: 44, identifier: "ZHOtherTableViewCellIdentifier")
        cell.setConfigCompletionHandle { (cell, indexPath) in
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = detailTitle
            cell.accessoryType = accessoryType
        }
    }

    func registerBlankCell(cell:ZHTableViewCell) {
        setCell(cell: cell, cellNumber: 1, anyClass: UITableViewCell.self, height: 10, identifier: "UITableViewCellBlankIdentifier")
        cell.setConfigCompletionHandle { (cell, indexPath) in
            cell.backgroundColor = UIColor.clear
        }
    }

    func setCell(cell:ZHTableViewCell, cellNumber:Int, anyClass:AnyClass?, height:CGFloat, identifier:String) {
        cell.cellNumber = cellNumber
        cell.anyClass = anyClass
        cell.height = height
        cell.identifier = identifier
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // 设置 UITableView 的组个数
    public func numberOfSections(in tableView: UITableView) -> Int {
        return ZHTableViewDataSource.numberOfSections(dataSource: self.dataSource)
    }

    // 设置组 Cell 的个数
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ZHTableViewDataSource.numberOfRowsInSection(dataSource: self.dataSource, section: section)
    }

    // 设置 Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZHTableViewDataSource.cellForRowAt(dataSource: self.dataSource, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }



    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZHTableViewDataSource.heightForRowAt(dataSource: self.dataSource, indexPath: indexPath, customHeightCompletionHandle: { () -> CGFloat in
            return 0
        })
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ZHTableViewDataSource.didSelectRowAt(dataSource: self.dataSource, indexPath: indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ZHTableViewDataSource.heightForHeaderInSection(dataSource: self.dataSource, section: section, customHeightCompletionHandle: { () -> CGFloat in
            return 0
        })
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ZHTableViewDataSource.heightForFooterInSection(dataSource: self.dataSource, section: section, customHeightCompletionHandle: { () -> CGFloat in
            return 0
        })
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ZHTableViewDataSource.viewForHeaderInSection(dataSource: self.dataSource, section: section)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return ZHTableViewDataSource.viewForFooterInSection(dataSource: self.dataSource, section: section)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController = segue.destination as? UINavigationController else {
            return
        }
        guard destinationController.viewControllers.count > 0 else {
            return
        }
        guard let listCellController  = destinationController.viewControllers.first as? ListCellViewController else {
            return
        }
        listCellController.selectTitles = self.list
        listCellController.setSaveCompletionHandle { (list) in
            self.list = list
            self.reloadCells()
        }

    }

}

