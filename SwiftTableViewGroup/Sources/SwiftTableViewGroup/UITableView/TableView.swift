//
//  TableView.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import Foundation
import UIKit.UITableView

public struct TableView : DataNode {
    public var sections:[TableSection] = []
    public let tableView:UITableView
    public lazy var delegate:TableViewDelegate = {
        TableViewDelegate(dataSource: self)
    }()
    public var isAutoDelegate = true
    public init(tableView:UITableView) {
        self.tableView = tableView
    }
    
    public mutating func setup(@TableBuilder _ block:() -> DataNode) {
        let node = block()
        if let group = node as? SectionGroup {
            sections = group.sections
        } else {
            let section = TableSection {
                SectionBuilder.tableSection(nodes: [node])
            }
            sections = [section]
        }
    }
    
    public mutating func reloadData() {
        self.registerClass()
        /// 检测到表格的代理还没有设置
        if self.tableView.dataSource == nil {
            /// 如果用户关闭了自动代理 则抱错提示用户
            if !self.isAutoDelegate {
                assertionFailure("如果自己设置 UITableView 代理则必须设置才能执行reloadData")
            } else {
                self.tableView.dataSource = self.delegate
            }
        }
        /// 如果检测到表格没有设置方法代理 则不必要强制用户去设置
        if self.tableView.delegate == nil && self.isAutoDelegate {
            self.tableView.delegate = self.delegate
        }
        self.tableView.reloadData()
    }
    
    public func registerClass() {
        for section in sections {
            if let header = section.header, header.identifier.count > 0 {
                self.tableView.register(header.anyClass, forHeaderFooterViewReuseIdentifier: header.identifier)
            }
            if let footer = section.footer, footer.identifier.count > 0 {
                self.tableView.register(footer.anyClass, forHeaderFooterViewReuseIdentifier: footer.identifier)
            }
            for cell in section.cells {
                self.tableView.register(cell.anyClass, forCellReuseIdentifier: cell.identifier)
            }
        }
    }
}


extension TableView {
    public enum TableViewContentType: String {
        case header = "header"
        case footer = "footer"
        case cell = "cell"
    }
}
