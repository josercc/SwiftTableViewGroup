//
//  ListCellViewController.swift
//  ZHTableViewGroupSwift
//
//  Created by 张行 on 2017/3/16.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import ZHTableViewGroupSwift

typealias ListCellViewControllerSaveCompletionHandle = (_ listTitles:[String]) -> Void

class ListCellViewController: UITableViewController {

    var dataSource:ZHTableViewDataSource?
    let cellTexts:[String] = ["Your Image","Your Background","E-mail","Name","Gender","Interest List","Blank Cell","Shipping Address Book"]
    var selectTitles:[String] = []

    private var saveCompletionHandle:ListCellViewControllerSaveCompletionHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 44
        self.dataSource = ZHTableViewDataSource(tableView: self.tableView)
        self.dataSource?.addGroup(completionHandle: { (group) in
            group.addCell(completionHandle: { (cell) in
                cell.anyClass = UITableViewCell.self
                cell.cellNumber = self.cellTexts.count
                cell.identifier = "UITableViewCellIdentifier"
                cell.setConfigCompletionHandle(configCompletionHandle: { (cell, indexPath) in
                    let string = self.cellTexts[indexPath.row]
                    cell.textLabel?.text = string
                    if self.selectTitles.contains(string) {
                        cell.accessoryType = .checkmark
                    } else {
                        cell.accessoryType = .none
                    }
                })
                cell.setDidSelectRowCompletionHandle(didSelectRowCompletionHandle: { (cell, indexPath) in
                    let string = self.cellTexts[indexPath.row]
                    if self.selectTitles.contains(string) {
                        guard let index = self.selectTitles.index(of: string) else {
                            return
                        }
                        self.selectTitles.remove(at: index)
                    } else {
                        self.selectTitles.append(string)
                    }
                    self.tableView.reloadData()
                })
            })

        })
        self.dataSource?.reloadTableViewData()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {

        var listTitles:[String] = []
        for string in self.cellTexts {
            if self.selectTitles.contains(string) {
                listTitles.append(string)
            }
        }
        guard let saveCompletionHandle = self.saveCompletionHandle else {
            return
        }
        saveCompletionHandle(listTitles)
        self.dismiss(animated: true, completion: nil)

    }
    func setSaveCompletionHandle(saveCompletionHandle:ListCellViewControllerSaveCompletionHandle?) {
        self.saveCompletionHandle = saveCompletionHandle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 设置 UITableView 的组个数
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return ZHTableViewDataSource.numberOfSections(dataSource: self.dataSource)
    }

    // 设置组 Cell 的个数
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ZHTableViewDataSource.numberOfRowsInSection(dataSource: self.dataSource, section: section)
    }

    // 设置 Cell
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZHTableViewDataSource.cellForRowAt(dataSource: self.dataSource, indexPath: indexPath as NSIndexPath)
        cell.selectionStyle = .none
        return cell
    }

    public override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ZHTableViewDataSource.didSelectRowAt(dataSource: self.dataSource, indexPath: indexPath as NSIndexPath)
    }

    
}
