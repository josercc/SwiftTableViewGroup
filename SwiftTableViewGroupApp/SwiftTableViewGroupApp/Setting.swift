//
//  Setting.swift
//  SwiftTableViewGroupApp
//
//  Created by 张行 on 2019/7/17.
//  Copyright © 2019 张行. All rights reserved.
//

import UIKit
import SwiftTableViewGroup
import SnapKit

class SettingHeaderView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = "Setting"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IntrinsicContentTextLabelCell: UITableViewCell {
    lazy var intrinsicContentTextLabel:UILabel = {
        let label = UILabel()
        label.text = "这个演示不设置高度自动根据 Cell 内部的`sizeThatFits`方法获取自适应高度的。需要自己实现`sizeThatFits`计算。这个演示不设置高度自动根据 Cell 内部的`sizeThatFits`方法获取自适应高度的。需要自己实现`sizeThatFits`计算。这个演示不设置高度自动根据 Cell 内部的`sizeThatFits`方法获取自适应高度的。需要自己实现`sizeThatFits`计算。这个演示不设置高度自动根据 Cell 内部的`sizeThatFits`方法获取自适应高度的。需要自己实现`sizeThatFits`计算。这个演示不设置高度自动根据 Cell 内部的`sizeThatFits`方法获取自适应高度的。需要自己实现`sizeThatFits`计算。这个演示不设置高度自动根据 Cell 内部的`sizeThatFits`方法获取自适应高度的。需要自己实现`sizeThatFits`计算。"
        label.font = UIFont.systemFont(ofSize: 20)
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 20
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.intrinsicContentTextLabel)
        self.intrinsicContentTextLabel.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.contentView)
            maker.leading.equalTo(self.contentView).offset(10)
            maker.trailing.equalTo(self.contentView).offset(-10)
        }
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        CGSize(width: size.width, height: 10 + self.intrinsicContentTextLabel.intrinsicContentSize.height + 10)
    }
}

