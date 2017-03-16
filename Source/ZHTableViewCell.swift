//
//  ZHTableViewCell.swift
//  Pods
//
//  Created by 张行 on 2017/3/15.
//
//

import UIKit

/*!
 *  ZHTableViewCell配置 cell 和 点击 cell 的回调
 *  @param cell: 需要配置或者点击 cell 的对象
 *  @param indexPath: cell 所在的索引位置
 */
public typealias ZHTableViewCellCompletionHandle = (_ cell:UITableViewCell, _ indexPath:NSIndexPath) -> Void

///  一组一样 cell 的托管器
public class ZHTableViewCell: NSObject {
    
    /// 标识符
    public var identifier:String?

    ///  cell 的高度
    public var height:CGFloat = CGFloat(NSNotFound)

    ///  cell 的数量
    public var cellNumber:Int = 0

    /// 配置 cell 的回调
    private var configCompletionHandle:ZHTableViewCellCompletionHandle?

    ///  点击 cell 的回调
    private var didSelectRowCompletionHandle:ZHTableViewCellCompletionHandle?

    /// 注册的 class 对象
    public var anyClass:AnyClass?

    /// 点击 cell
    ///
    /// - Parameters:
    ///   - cell: 对应的UITableViewCell
    ///   - indexPath: 索引的位置
    func didSelectRowAt(cell:UITableViewCell, indexPath:NSIndexPath) {
        guard let didSelectRowCompletionHandle = self.didSelectRowCompletionHandle else {
            // 如果用户没有设置回调就直接返回
            return
        }
        didSelectRowCompletionHandle(cell,indexPath) // 执行点击的回调
    }

    /// 配置 cell
    ///
    /// - Parameters:
    ///   - cell: 对应的UITableViewCell
    ///   - indexPath: 索引的位置
    func configCell(cell:UITableViewCell?, indexPath:NSIndexPath)  {
        guard let configCompletionHandle = self.configCompletionHandle else {
            // 如果用户没有实现配置的回调就返回
            return
        }
        guard let cell = cell else {
            // 如果 cell 不存在就返回
            return
        }
        configCompletionHandle(cell,indexPath) // 执行配置的回调
    }

    ///  设置配置回调
    ///
    /// - Parameter configCompletionHandle: 配置回调
    public func setConfigCompletionHandle(configCompletionHandle:ZHTableViewCellCompletionHandle?) {
        self.configCompletionHandle = configCompletionHandle
    }

    ///  配置点击的回调
    ///
    /// - Parameter didSelectRowCompletionHandle: 点击的回调
    public func setDidSelectRowCompletionHandle(didSelectRowCompletionHandle:ZHTableViewCellCompletionHandle?) {
        self.didSelectRowCompletionHandle = didSelectRowCompletionHandle
    }


}
