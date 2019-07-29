//
//  TableCell.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewCell


public final class TableCell: DataContentView, ContentView, TableContentView {
    public var makeTypeBlock: ((BlockContent, TableCell) -> Void)?
    public typealias View = UITableViewCell
    public init<V:UITableViewCell>(_ type: V.Type = V.self, _ block: MakeTypeBlock? = nil) {
        super.init(anyClass: V.self)
        self.makeTypeBlock = block
    }
}




