//
//  TableViewRegiterGroup.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewHeaderFooterView

public struct TableViewRegiterGroup : DataNode {
    public var header:TableHeaderView?
    public var footer:TableFooterView?
    public var cells:[TableCell]
}
