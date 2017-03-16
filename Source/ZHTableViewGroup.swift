//
//  ZHTableViewGroup.swift
//  Pods
//
//  Created by 张行 on 2017/3/14.
//
//

import UIKit

public typealias ZHTableViewGroupAddCellCompletionHandle = (_ cell:ZHTableViewCell) -> Void
public typealias ZHTableViewGroupAddHeaderFooterCompletionHandle = (_ headerFooter:ZHTableViewHeaderFooter) -> Void

public class ZHTableViewGroup: NSObject {

    var cells:[ZHTableViewCell] = []

    public var header:ZHTableViewHeaderFooter?

    public var footer:ZHTableViewHeaderFooter?

    var cellCount:Int {
        get {
            var count:Int = 0 // 初始化默认 Cell 的数量为0
            for cell in self.cells {
                // 便利 cells 数组的 ZHTableViewCell 的对象
                count += cell.cellNumber // 对ZHTableViewCell的 cell 数量进行累加
            }
            return count
        }
    }

    
    public func addCell(completionHandle:ZHTableViewGroupAddCellCompletionHandle) {
        let cell = ZHTableViewCell()
        completionHandle(cell)
        cells.append(cell)
    }

    public func addHeader(completionHandle:ZHTableViewGroupAddHeaderFooterCompletionHandle) {
        let header = ZHTableViewHeaderFooter(style: .header)
        completionHandle(header)
        self.header = header
    }

    public func addFooter(completionHandle:ZHTableViewGroupAddHeaderFooterCompletionHandle) {
        let footer = ZHTableViewHeaderFooter(style: .footer)
        completionHandle(footer)
        self.footer = footer
    }

    /// 获取对应的 UITableViewCell
    ///
    /// - Parameters:
    ///   - tableView: 对应的表格 可能为 nil
    ///   - indexPath: 对应的 IndexPath 索引
    /// - Returns: UITableViewCell可能为 nil
    func cellForTableView(tableView:UITableView?, atIndexPath indexPath:NSIndexPath) -> UITableViewCell? {
        guard let tableView = tableView else {
            // 当表格不存在返回 nil
            return nil
        }
        guard let tableViewCell = tableViewCellForIndexPath(indexPath: indexPath) else {
            // 如果索引获取不到对应的 ZHTableViewCell 就返回 nil
            return nil
        }
        guard let identifier = tableViewCell.identifier else {
            // 如果用户没有设置 Identifier 就返回 nil
            return nil
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) // 获取重用的 Cell
        tableViewCell.configCell(cell: cell, indexPath: indexPath) // 配置 cell
        return cell
    }

    func headerFooterForStyle(tableView:UITableView?, style:ZHTableViewHeaderFooterStyle) -> UITableViewHeaderFooterView? {
        guard let tableView = tableView else {
            return nil
        }
        var headerFooter:ZHTableViewHeaderFooter?
        switch style {
        case .header:
            headerFooter = self.header
        case .footer:
            headerFooter = self.footer
        }

        guard let _ = headerFooter else {
            return nil
        }

        guard let identifier = headerFooter!.identifier else {
            return nil
        }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
    }

    func registerHeaderFooterCell(tableView:UITableView) {
        if let headerIdentifier = self.header?.identifier {
            tableView.register(self.header?.anyClass, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        }

        if let footerIdentifier = self.footer?.identifier {
            tableView.register(self.footer?.anyClass, forHeaderFooterViewReuseIdentifier: footerIdentifier)
        }

        for cell in self.cells {
            if let cellIdentifier = cell.identifier {
                tableView.register(cell.anyClass, forCellReuseIdentifier: cellIdentifier)
            }
        }
    }

    /// 根本索引获取对应的ZHTableViewCell
    ///
    /// - Parameter indexPath:  IndexPath 的索引
    /// - Returns: ZHTableViewCell可能为 nil
    func tableViewCellForIndexPath(indexPath:NSIndexPath) -> ZHTableViewCell? {
        guard indexPath.row < self.cellCount else {
            // 如果索引超出了总个数就返回 nil
            return nil
        }
        var count:Int = 0 // 设置 cell 总数初始值
        var tableViewCell:ZHTableViewCell? // 保存ZHTableViewCell变量
        for cell in self.cells {
            // 便利 cells 数组里面的ZHTableViewCell
            count += cell.cellNumber // 累加 cell 的数量
            if indexPath.row < count {
                // 当索引在当前ZHTableViewCell范围内 就返回ZHTableViewCell对象
                tableViewCell = cell
                break
            }
        }
        return tableViewCell
    }

}
