//
//  ZHTableViewHeaderFooter.swift
//  Pods
//
//  Created by 张行 on 2017/3/15.
//
//

import UIKit

public enum  ZHTableViewHeaderFooterStyle {
    case header
    case footer
}

public class ZHTableViewHeaderFooter: NSObject {

    let style:ZHTableViewHeaderFooterStyle

    var identifier:String?

    var anyClass:AnyClass?

    var height:CGFloat = CGFloat(NSNotFound)

    init(style:ZHTableViewHeaderFooterStyle) {
        self.style = style
        super.init()
    }
}
