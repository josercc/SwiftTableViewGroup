//
//  TableContentView.swift
//  
//
//  Created by zhang hang on 2019/7/26.
//

import UIKit.UIView

public class BlockContent {
    public enum BlockType {
        case configuration
        case didSelectRow
        case customHeight
        case customSize
        case custonInset
    }
    public var view:UIView
    public var index:Int
    public var blockType:BlockType
    public var customHeight:CGFloat = -1
    public var customSize:CGSize = CGSize(width: -1, height: -1)
    init(view:UIView, index:Int, blockType:BlockType) {
        self.view = view
        self.index = index
        self.blockType = blockType
    }
    public func configuration<V:UIView>(_ type:V.Type = V.self, _ block:(V,Int) -> Void) {
        guard let contentView = self.view as? V, self.blockType == .configuration else {
            return
        }
        block(contentView,self.index)
    }
    public func didSelectRow<V:UIView>(_ type:V.Type = V.self, _ block:(V,Int) -> Void) {
        guard let contentView = self.view as? V, self.blockType == .didSelectRow else {
            return
        }
        block(contentView,self.index)
    }
    
    public func customHeight<V:UIView>(_ type:V.Type = V.self, _ block:(V,Int) -> CGFloat) {
        guard let contentView = self.view as? V, self.blockType == .customHeight else {
            return
        }
        self.customHeight = block(contentView,self.index)
    }
    public func customSize<V:UIView>(_ type:V.Type = V.self, _ block:(V,Int) -> CGSize) {
        guard let contentView = self.view as? V, self.blockType == .customSize else {
            return
        }
        self.customSize = block(contentView,self.index)
    }
    
}


public protocol ContentView  {
    associatedtype View:UIView
    typealias MakeTypeBlock = (BlockContent,Self) -> Void
    var makeTypeBlock:MakeTypeBlock? { get set }
    func makeConfig(view:UIView, index:Int)
    func makeDidSelectRow(view:UIView, index:Int)
    func makeCustomHeight(view:UIView, index:Int) -> CGFloat
    func makeCustomSize(view:UIView, index:Int) -> CGSize
}

extension ContentView {
    public func makeConfig(view:UIView, index:Int) {
        self.makeTypeBlock?(BlockContent(view: view, index: index, blockType: .configuration),self)
    }
    
    public func makeDidSelectRow(view:UIView, index:Int) {
        self.makeTypeBlock?(BlockContent(view: view, index: index, blockType: .didSelectRow),self)
    }
    
    public func makeCustomHeight(view:UIView, index:Int) -> CGFloat {
        let content = BlockContent(view: view, index: index, blockType: .customHeight)
        self.makeTypeBlock?(content,self)
        return content.customHeight
    }
    public func makeCustomSize(view:UIView, index:Int) -> CGSize {
        let content = BlockContent(view: view, index: index, blockType: .customSize)
        self.makeTypeBlock?(content,self)
        return content.customSize
    }
}

public class DataContentView : ViewRegister {
    public var anyClass: AnyClass
    public var identifier: String
    public init(anyClass:AnyClass) {
        self.anyClass = anyClass
        self.identifier = "\(anyClass)"
    }
}
