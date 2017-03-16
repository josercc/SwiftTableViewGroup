//
//  ZHBaseTableViewCell.swift
//  ZHTableViewGroupSwift
//
//  Created by 张行 on 2017/3/15.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

protocol ZHBaseTableViewCellDelegate {
    var iconSize:CGSize { get }
    var isAllowCorner:Bool { get }
}

class ZHBaseTableViewCell: UITableViewCell {
    let iconImageView:UIImageView = UIImageView(frame: CGRect.zero)
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var isAllowCorner = false
        var iconSize = CGSize.zero
        if let delegate = self as? ZHBaseTableViewCellDelegate {
            isAllowCorner = delegate.isAllowCorner
            iconSize = delegate.iconSize
        }
        if isAllowCorner {
            self.iconImageView.layer.masksToBounds = true
            self.iconImageView.layer.cornerRadius = iconSize.height / 2.0
        }

        self.iconImageView.backgroundColor = UIColor.darkGray
        self.textLabel?.text = ""
        self.contentView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.contentView).offset(-3)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(iconSize)
        }
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
