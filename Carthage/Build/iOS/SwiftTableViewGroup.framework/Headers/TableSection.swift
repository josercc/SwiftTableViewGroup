//
//  TableSection.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewCell

public struct TableSection : DataNode {
    public var header:TableHeaderView?
    public var footer:TableFooterView?
    public var cells:[TableCell] = [TableCell]()
    public init(@TableSectionBuilder _ block:() -> DataNode) {
        if let group = block() as? TableViewRegiterGroup {
            self.header = group.header
            self.footer = group.footer
            self.cells = group.cells
        }
    }
    public func number() -> Int {
        var count = 0
        for cell in cells {
            count += cell.number
        }
        return count
    }
    
    /// 1 2 3
    public func cell(index:Int) -> (cell:TableCell, index:Int) {
        var count = 0
        for cell in cells {
            let countIndex = count + cell.number
            if index < countIndex {
                return (cell, index - count)
            }
            count = countIndex
        }
        return (cells[0],0)
    }
}
