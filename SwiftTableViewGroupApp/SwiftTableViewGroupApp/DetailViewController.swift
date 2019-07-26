//
//  DetailViewController.swift
//  SwiftTableViewGroupApp
//
//  Created by 张行 on 2019/7/17.
//  Copyright © 2019 张行. All rights reserved.
//

import UIKit
import SwiftTableViewGroup

class DetailViewController: UIViewController {
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return tableView
    }()
    
    var dataSource:TableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.dataSource?.reloadData()
    }
    
    

}
