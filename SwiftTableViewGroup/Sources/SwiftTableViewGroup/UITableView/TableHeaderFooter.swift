//
//  TableHeaderFooter.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewHeaderFooterView

public typealias HeaderFooterMakeTypeBlock = (_ tableHeaderFooter:TableHeaderFooterView, _ headerFooter:UITableViewHeaderFooterView, _ section:Int) -> Void
public class TableHeaderFooterView : ViewRegister {
    public enum HeaderFooterType {
        case header
        case footer
    }
    public var anyClass: AnyClass
    public var identifier: String
    public var height: CGFloat = 0
    public var number: Int = 1
    public var viewType:HeaderFooterType
    var makeTypeBlock:HeaderFooterMakeTypeBlock?
    public init<T:UITableViewHeaderFooterView>(_ type:T.Type = T.self, _ viewType:HeaderFooterType = .header, _ makeTypeBlock: HeaderFooterMakeTypeBlock? = nil) {
        self.anyClass = T.self
        self.identifier = "\(T.self)"
        self.viewType = viewType
        self.makeTypeBlock = makeTypeBlock
    }
    func makeHeaderFooterConfig(headerFooter:UITableViewHeaderFooterView, section:Int) {
        self.makeTypeBlock?(self,headerFooter,section)
    }
    public func makeContentBlock<T>(headerFooter:UITableViewHeaderFooterView, section:Int, configContent:HeaderFooterBlockContent<T>? = nil) {
        guard let view = headerFooter as? T, let blockContent = configContent else {
            return
        }
        blockContent.block(view,section)
    }
    @discardableResult
    public func height(_ height:CGFloat) -> TableHeaderFooterView {
        self.height = height
        return self
    }
}

public class HeaderFooterBlockContent<T:UITableViewHeaderFooterView> {
    public typealias Block = (_ headerFooter:T, _ section:Int) -> Void
    var block:Block
    public init(_ block:@escaping Block) {
        self.block = block
    }
}
