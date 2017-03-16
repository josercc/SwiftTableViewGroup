//
//  ZHCellTwoTableViewCell.swift
//  ZHTableViewGroupSwift
//
//  Created by 张行 on 2017/3/15.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class ZHCellTwoTableViewCell:ZHBaseTableViewCell, ZHBaseTableViewCellDelegate {
    var isAllowCorner: Bool {
        get {
            return false
        }
    }

    var iconSize: CGSize {
        get {
            return CGSize(width: 80, height: 37)
        }
    }
}
