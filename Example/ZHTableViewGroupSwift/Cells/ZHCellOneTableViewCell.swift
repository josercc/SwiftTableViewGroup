//
//  ZHCellOneTableViewCell.swift
//  ZHTableViewGroupSwift
//
//  Created by 张行 on 2017/3/15.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class ZHCellOneTableViewCell: ZHBaseTableViewCell, ZHBaseTableViewCellDelegate {
    var isAllowCorner: Bool {
        get {
            return true
        }
    }

    var iconSize: CGSize {
        get {
            return CGSize(width: 51, height: 51)
        }
    }

}
