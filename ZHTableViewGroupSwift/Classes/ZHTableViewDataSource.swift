//
//  ZHTableViewDataSource.swift
//  Pods
//
//  Created by 张行 on 2017/3/14.
//
//

import UIKit

/// 添加分组的回调 group:回调的ZHTableViewGroup
public typealias ZHTableViewAddGroupCompletionHandle = (_ group:ZHTableViewGroup) -> Void
public typealias ZHTableViewDataSourceCustomHeightCompletionHandle = () -> CGFloat

public class ZHTableViewDataSource: NSObject {

    /// 添加分组
    ///
    /// - Parameter completionHandle: 添加分组配置的回调
    public func addGroup(completionHandle:ZHTableViewAddGroupCompletionHandle) {
        let group = ZHTableViewGroup()
        completionHandle(group)
        groups.append(group)
    }

    /// ZHTableViewGroup的数组
    public var groups:[ZHTableViewGroup] = []

    /// 初始化ZHTableViewDataSource数据源
    ///
    /// - Parameter tableView: 表格对象
    public init(tableView:UITableView) {
        self.tableView = tableView
        super.init()
    }

    /// 托管 UITableView 的对象
    var tableView:UITableView

    public func reloadTableViewData() {
        self.registerClass()
        self.tableView.reloadData()
    }

    func registerClass() {
        for group in self.groups {
            group.registerHeaderFooterCell(tableView: self.tableView)
        }
    }

    /// 返回每组 Cell 的总数
    ///
    /// - Parameters:
    ///   - dataSource: ZHTableViewDataSource数据源对象可以为 nil
    ///   - section: 组的索引
    /// - Returns:  cell的总数
    public class func numberOfRowsInSection(dataSource:ZHTableViewDataSource?, section:Int) -> Int {
        guard let group = groupForSection(dataSource: dataSource, section: section) else {
            // 如果获取不到对应的 ZHTableViewGroup 对象就返回0
            return 0
        }
        return group.cellCount
    }

    /// 返回对应的UITableViewCell
    ///
    /// - Parameters:
    ///   - dataSource: ZHTableViewDataSource数据源可以为空
    ///   - indexPath: 获取所在的 IndexPath
    /// - Returns: UITableViewCell
    public class func cellForRowAt(dataSource:ZHTableViewDataSource?, indexPath:IndexPath) -> UITableViewCell {
        guard let group = groupForSection(dataSource: dataSource, section: indexPath.section) else {
            // 当分组不存在返回默认的UITableViewCell
            return UITableViewCell()
        }
        guard let cell = group.cellForTableView(tableView: dataSource?.tableView, atIndexPath: indexPath) else {
            // 当获取UITableViewCell 获取不到返回默认的UITableViewCell
            return UITableViewCell()
        }
        return cell
    }

    ///  获取对应的分组
    ///
    /// - Parameters:
    ///   - dataSource: ZHTableViewDataSource的数据源可以为 nil
    ///   - section: 分组的索引
    /// - Returns: 对应分组对象可能为 nil
    class func groupForSection(dataSource:ZHTableViewDataSource?, section:Int) -> ZHTableViewGroup? {
        guard let dataSource = dataSource else {
            // 当用户还没有创建ZHTableViewDataSource对象返回 nil
            return nil
        }
        guard dataSource.groups.count > section else {
            // 当取值的索引超出了边界返回 nil
            return nil
        }
        return dataSource.groups[section]
    }

    class func cellForIndexPath(dataSource:ZHTableViewDataSource?, atIndexPath indexPath:IndexPath) -> ZHTableViewCell? {
        guard let group = groupForSection(dataSource: dataSource, section: indexPath.section) else {
            return nil
        }
        return group.tableViewCellForIndexPath(indexPath: indexPath)
    }

    /// 返回分组的个数
    ///
    /// - Parameter dataSource: ZHTableViewDataSource数据源可以为 nil
    /// - Returns: Int分组的个数
    public class func numberOfSections(dataSource:ZHTableViewDataSource?) -> Int {
        guard let dataSource = dataSource else {
            // 当ZHTableViewDataSource用户对象还没有创建的时候返回0
            return 0
        }
        return dataSource.groups.count // 返回 ZHTableViewGroup 数组的个数
    }

    public class func heightForRowAt(dataSource:ZHTableViewDataSource?, indexPath:IndexPath, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        guard let cell = cellForIndexPath(dataSource: dataSource, atIndexPath: indexPath) else {
            return 0
        }
        return heightWithCustomHandle(height: cell.height, customCompletionHandle: customHeightCompletionHandle)
    }

    class func heightWithCustomHandle(height:CGFloat, customCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        if height == CGFloat(NSNotFound) {
            guard let customCompletionHandle = customCompletionHandle else {
                return 0
            }
            return customCompletionHandle()
        } else {
            return height
        }
    }

    public class func didSelectRowAt(dataSource:ZHTableViewDataSource?, indexPath:IndexPath) {
        guard let tableViewCell = cellForIndexPath(dataSource: dataSource, atIndexPath: indexPath) else {
            return
        }
        let cell = cellForRowAt(dataSource: dataSource, indexPath: indexPath)
        tableViewCell.didSelectRowAt(cell: cell, indexPath: indexPath)
    }

    public class func heightForHeaderInSection(dataSource:ZHTableViewDataSource?, section:Int, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        return heightForHeaderFooterInSection(dataSource: dataSource, section: section, customHeightCompletionHandle: customHeightCompletionHandle, headerFooterStyle: .header)
    }

    public class func heightForFooterInSection(dataSource:ZHTableViewDataSource?, section:Int, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        return heightForHeaderFooterInSection(dataSource: dataSource, section: section, customHeightCompletionHandle: customHeightCompletionHandle, headerFooterStyle: .footer)
    }

    class func heightForHeaderFooterInSection(dataSource:ZHTableViewDataSource?, section:Int, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?, headerFooterStyle:ZHTableViewHeaderFooterStyle) -> CGFloat {
        guard let group = groupForSection(dataSource: dataSource, section: section) else {
            return 0
        }
        var height:CGFloat = 0
        switch headerFooterStyle {
        case .header:
            guard let header = group.header else {
                return 0
            }
            height = header.height
        case .footer:
            guard let footer = group.footer else {
                return 0
            }
            height = footer.height
        }
        return heightWithCustomHandle(height: height, customCompletionHandle: customHeightCompletionHandle)
    }

    public class func viewForHeaderInSection(dataSource:ZHTableViewDataSource?, section:Int) ->UITableViewHeaderFooterView? {
        return viewHeaderFooterInSection(dataSource: dataSource, section: section, style: .header)
    }

    public class func viewForFooterInSection(dataSource:ZHTableViewDataSource?, section:Int) -> UITableViewHeaderFooterView? {
        return viewHeaderFooterInSection(dataSource: dataSource, section: section, style: .footer)
    }

    class func viewHeaderFooterInSection(dataSource:ZHTableViewDataSource?, section:Int, style:ZHTableViewHeaderFooterStyle) -> UITableViewHeaderFooterView? {
        guard let group = groupForSection(dataSource: dataSource, section: section) else {
            return nil
        }
        return group.headerFooterForStyle(tableView: dataSource?.tableView, style: style)
    }

    public func clearData() {
        self.groups.removeAll()
    }
}
