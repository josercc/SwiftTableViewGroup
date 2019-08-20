//
//  CollectionHeaderFooter.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UICollectionView

public final class CollectionHeaderView : DataContentView, ContentView, CollectionContentView {
    public var makeTypeBlock: ((BlockContent, CollectionHeaderView) -> Void)?
    public typealias View = UICollectionReusableView
    public init<V:UICollectionReusableView>(_ type: V.Type = V.self, _ block: MakeTypeBlock? = nil) {
        super.init(anyClass: V.self)
        self.makeTypeBlock = block
    }
}

public final class CollectionFooterView : DataContentView, ContentView, CollectionContentView {
    public var makeTypeBlock: ((BlockContent, CollectionFooterView) -> Void)?
    public typealias View = UICollectionReusableView
    public init<V:UICollectionReusableView>(_ type: V.Type = V.self, _ block: MakeTypeBlock? = nil) {
        super.init(anyClass: V.self)
        self.makeTypeBlock = block
    }
}
