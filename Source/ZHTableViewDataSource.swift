//
//  ZHTableViewDataSource.swift
//  Pods
//
//  Created by 张行 on 2017/3/14.
//
//

import UIKit

/*!
 *  添加分组的回调
 *  @param group: 对应ZHTableViewGroup
 */
public typealias ZHTableViewAddGroupCompletionHandle = (_ group:ZHTableViewGroup) -> Void
/*!
 *  自定义高度回调
 */
public typealias ZHTableViewDataSourceCustomHeightCompletionHandle = () -> CGFloat

///  配置 UITableView的数据源
public class ZHTableViewDataSource: NSObject {

    /// 添加分组
    ///
    /// - Parameter completionHandle: 添加分组配置的回调
    public func addGroup(completionHandle:ZHTableViewAddGroupCompletionHandle) {
        let group = ZHTableViewGroup() // 创建分组
        completionHandle(group) // 让用户配置分组
        groups.append(group) // 把分组防止在数组里面
    }

    /// ZHTableViewGroup的数组
    private var groups:[ZHTableViewGroup] = []

    /// 初始化ZHTableViewDataSource数据源
    ///
    /// - Parameter tableView: 表格对象
    public init(tableView:UITableView) {
        self.tableView = tableView
        super.init()
    }

    /// 托管 UITableView 的对象
    private var tableView:UITableView

    ///  重新刷新表格
    public func reloadTableViewData() {
        self.registerClass() // 注册对应的 Cell
        self.tableView.reloadData()
    }

    private func registerClass() {
        for group in self.groups {
            // 便利所有的分组 进行注册
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
    public class func cellForRowAt(dataSource:ZHTableViewDataSource?, indexPath:NSIndexPath) -> UITableViewCell {
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
    private class func groupForSection(dataSource:ZHTableViewDataSource?, section:Int) -> ZHTableViewGroup? {
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

    private class func cellForIndexPath(dataSource:ZHTableViewDataSource?, atIndexPath indexPath:NSIndexPath) -> ZHTableViewCell? {
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

    /// 获取 cell 的高度
    ///
    /// - Parameters:
    ///   - dataSource: ZHTableViewDataSource数组源
    ///   - indexPath: 索引位置
    ///   - customHeightCompletionHandle: 自定义高度方法回调
    /// - Returns:  cell 的高度
    public class func heightForRowAt(dataSource:ZHTableViewDataSource?, indexPath:NSIndexPath, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        guard let cell = cellForIndexPath(dataSource: dataSource, atIndexPath: indexPath) else {
            // 如果 ZHTableViewCell 不存在就直接返回0
            return 0
        }
        return heightWithCustomHandle(height: cell.height, customCompletionHandle: customHeightCompletionHandle)
    }

    ///  返回高度
    ///
    /// - Parameters:
    ///   - height: 固定的高度
    ///   - customCompletionHandle: 自定义高度回调
    /// - Returns: 高度
    private class func heightWithCustomHandle(height:CGFloat, customCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        if height == CGFloat(NSNotFound) {
            // 如果用户没有设置高度 就查看用户是否自定义高度方法
            guard let customCompletionHandle = customCompletionHandle else {
                // 如果用户自定义高度方法不存在 就返回0
                return 0
            }
            return customCompletionHandle() // 返回用户的自定义高度
        } else {
            return height // 返回用户提前设定的固定高度
        }
    }

    /// 点击 cell
    ///
    /// - Parameters:
    ///   - dataSource: ZHTableViewDataSource数据源
    ///   - indexPath: 索引位置
    public class func didSelectRowAt(dataSource:ZHTableViewDataSource?, indexPath:NSIndexPath) {
        guard let tableViewCell = cellForIndexPath(dataSource: dataSource, atIndexPath: indexPath) else {
            // 当找不到 ZHTableViewCell 不存在就直接返回
            return
        }
        let cell = cellForRowAt(dataSource: dataSource, indexPath: indexPath) // 获取点击的 cell
        tableViewCell.didSelectRowAt(cell: cell, indexPath: indexPath) // 告诉ZHTableViewCell 点击了 cell
    }

    public class func heightForHeaderInSection(dataSource:ZHTableViewDataSource?, section:Int, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        return heightForHeaderFooterInSection(dataSource: dataSource, section: section, customHeightCompletionHandle: customHeightCompletionHandle, headerFooterStyle: .header)
    }

    public class func heightForFooterInSection(dataSource:ZHTableViewDataSource?, section:Int, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?) -> CGFloat {
        return heightForHeaderFooterInSection(dataSource: dataSource, section: section, customHeightCompletionHandle: customHeightCompletionHandle, headerFooterStyle: .footer)
    }

    private class func heightForHeaderFooterInSection(dataSource:ZHTableViewDataSource?, section:Int, customHeightCompletionHandle:ZHTableViewDataSourceCustomHeightCompletionHandle?, headerFooterStyle:ZHTableViewHeaderFooterStyle) -> CGFloat {
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

    private class func viewHeaderFooterInSection(dataSource:ZHTableViewDataSource?, section:Int, style:ZHTableViewHeaderFooterStyle) -> UITableViewHeaderFooterView? {
        guard let group = groupForSection(dataSource: dataSource, section: section) else {
            return nil
        }
        return group.headerFooterForStyle(tableView: dataSource?.tableView, style: style)
    }

    public func clearData() {
        self.groups.removeAll()
    }
}
