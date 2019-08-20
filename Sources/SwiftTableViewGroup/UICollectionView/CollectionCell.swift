//
//  CollectionCell.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UICollectionViewCell


public final class CollectionCell: DataContentView, ContentView, CollectionContentView {
    public var makeTypeBlock: ((BlockContent, CollectionCell) -> Void)?
    public typealias View = UICollectionViewCell
    public init<V:UICollectionViewCell>(_ type: V.Type = V.self, _ block: MakeTypeBlock? = nil) {
        super.init(anyClass: V.self)
        self.makeTypeBlock = block
    }
}




