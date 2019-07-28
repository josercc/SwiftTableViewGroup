//
//  CollectionViewRegiterGroup.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UICollectionView

public struct CollectionViewRegiterGroup : DataNode {
    public var header:CollectionHeaderView?
    public var footer:CollectionFooterView?
    public var cells:[CollectionCell]
}
