//
//  TableHeaderFooter.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewHeaderFooterView

public final class TableHeaderView : DataContentView, ContentView, TableContentView {
    public var makeTypeBlock: ((BlockContent, TableHeaderView) -> Void)?
    public typealias View = UITableViewHeaderFooterView
    public init<V:UITableViewHeaderFooterView>(_ type: V.Type = V.self, _ block: MakeTypeBlock? = nil) {
        super.init(anyClass: V.self)
        self.makeTypeBlock = block
    }
}

public final class TableFooterView : DataContentView, ContentView, TableContentView {
    public var makeTypeBlock: ((BlockContent, TableFooterView) -> Void)?
    public typealias View = UITableViewHeaderFooterView
    public init<V:UITableViewHeaderFooterView>(_ type: V.Type = V.self, _ block: MakeTypeBlock? = nil) {
        super.init(anyClass: V.self)
        self.makeTypeBlock = block
    }
}
