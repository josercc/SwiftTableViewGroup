//
//  TableCell.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewCell

public typealias CellMakeTypeBlock = (_ tableCell:TableCell, _ type:TableCell.CellBlockType,_ cell:UITableViewCell, _ index:Int) -> Void
public class TableCell: ViewRegister {
    public enum CellBlockType {
        case config
        case didSelectRow
    }
    public var anyClass: AnyClass
    public var identifier: String
    public var height: CGFloat = 0
    public var number: Int = 1
    var makeTypeBlock:CellMakeTypeBlock?
    public init<T:UITableViewCell>(_ type:T.Type = T.self, _ makeTypeBlock: CellMakeTypeBlock? = nil) {
        self.anyClass = T.self
        self.identifier = "\(T.self)"
        self.makeTypeBlock = makeTypeBlock
    }
    @discardableResult
    public func number(_ number:Int) -> TableCell {
        self.number = number
        return self
    }
    @discardableResult
    public func height(_ height:CGFloat) -> TableCell {
        self.height = height;
        return self
    }
    public func makeContentBlock<T:UITableViewCell>(type:CellBlockType, cell:UITableViewCell, index:Int, configContent:CellBlockContent<T>? = nil, didSelectRowContent:CellBlockContent<T>? = nil) {
        guard let view = cell as? T else {
            return
        }
        if type == .config, let blockContent = configContent {
            blockContent.block(view,index)
        } else if type == .didSelectRow, let blockContent = didSelectRowContent {
            blockContent.block(view,index)
        }
    }
    func makeCellConfig(cell:UITableViewCell, index:Int) {
        self.makeTypeBlock?(self,.config,cell,index)
    }
    
    func makeCellDidSelectRow(cell:UITableViewCell, index:Int) {
        self.makeTypeBlock?(self,.didSelectRow,cell,index)
    }
}


public class CellBlockContent<T:UITableViewCell> {
    public typealias Block = (_ cell:T, _ index:Int) -> Void
    var block:Block
    public init(_ block:@escaping Block) {
        self.block = block
    }
}
