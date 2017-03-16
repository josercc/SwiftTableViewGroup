//
//  ZHTableViewCell.swift
//  Pods
//
//  Created by 张行 on 2017/3/15.
//
//

import UIKit

public typealias ZHTableViewCellCompletionHandle = (_ cell:UITableViewCell, _ indexPath:IndexPath) -> Void

public class ZHTableViewCell: NSObject {
    
    public var identifier:String?

    public var height:CGFloat = CGFloat(NSNotFound)

    public var cellNumber:Int = 0

    private var configCompletionHandle:ZHTableViewCellCompletionHandle?

    private var didSelectRowCompletionHandle:ZHTableViewCellCompletionHandle?

    public var anyClass:AnyClass?

    func didSelectRowAt(cell:UITableViewCell, indexPath:IndexPath) {
        guard let didSelectRowCompletionHandle = self.didSelectRowCompletionHandle else {
            return
        }
        didSelectRowCompletionHandle(cell,indexPath)
    }

    func configCell(cell:UITableViewCell?, indexPath:IndexPath)  {
        guard let configCompletionHandle = self.configCompletionHandle else {
            return
        }
        guard let cell = cell else {
            return
        }
        configCompletionHandle(cell,indexPath)
    }

    public func setConfigCompletionHandle(configCompletionHandle:ZHTableViewCellCompletionHandle?) {
        self.configCompletionHandle = configCompletionHandle
    }

    public func setDidSelectRowCompletionHandle(didSelectRowCompletionHandle:ZHTableViewCellCompletionHandle?) {
        self.didSelectRowCompletionHandle = didSelectRowCompletionHandle
    }


}
