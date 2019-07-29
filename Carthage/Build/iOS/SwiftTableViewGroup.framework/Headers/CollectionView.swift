//
//  CollectionView.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import Foundation
import UIKit.UICollectionView

public class CollectionView : DataNode {
    public var sections:[CollectionSection] = []
    public let collectionView:UICollectionView
    public lazy var delegate:CollectionViewDelegate = {
        CollectionViewDelegate(dataSource: self)
    }()
    public var isAutoDelegate = true
    public var inset:UIEdgeInsets = .zero
    public var insetBlock:((Int) -> UIEdgeInsets)?
    public var minimumLineSpacingBlock:((Int) -> CGFloat)?
    public var minimumLineSpacing:CGFloat = 0
    public var minimumInteritemSpacingBlock:((Int) -> CGFloat)?
    public var minimumInteritemSpacing:CGFloat = 0
    public init(collectionView:UICollectionView) {
        self.collectionView = collectionView
    }
    @discardableResult
    public func setup(@CollectionBuilder _ block:() -> DataNode) -> CollectionView {
        let node = block()
        if let group = node as? CollectionSectionGroup {
            sections = group.sections
        } else {
            let section = CollectionSection {
                CollectionSectionBuilder.collectionSection(nodes: [node])
            }
            sections = [section]
        }
        return self
    }
    @discardableResult
    public func customInset(_ block:@escaping ((Int) -> UIEdgeInsets)) -> CollectionView {
        self.insetBlock = block
        return self
    }
    @discardableResult
    public func inset(_ inset:UIEdgeInsets) -> CollectionView {
        self.inset = inset
        return self
    }
    @discardableResult
    public func customMinimumLineSpacing(_ block:@escaping ((Int) -> CGFloat)) -> CollectionView {
        self.minimumLineSpacingBlock = block
        return self
    }
    @discardableResult
    public func minimumLineSpacing(_ minimumLineSpacing:CGFloat) -> CollectionView {
        self.minimumLineSpacing = minimumLineSpacing
        return self
    }
    @discardableResult
    public func customMinimumInteritemSpacing(_ block:@escaping ((Int) -> CGFloat)) -> CollectionView {
        self.minimumInteritemSpacingBlock = block
        return self
    }
    @discardableResult
    public func minimumInteritemSpacing(_ minimumInteritemSpacing:CGFloat) -> CollectionView {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
    public func reloadData() {
        self.registerClass()
        /// 检测到表格的代理还没有设置
        if self.collectionView.dataSource == nil {
            /// 如果用户关闭了自动代理 则抱错提示用户
            if !self.isAutoDelegate {
                assertionFailure("如果自己设置 UICollectionView 代理则必须设置才能执行reloadData")
            } else {
                self.collectionView.dataSource = self.delegate
            }
        }
        /// 如果检测到表格没有设置方法代理 则不必要强制用户去设置
        if self.collectionView.delegate == nil && self.isAutoDelegate {
            self.collectionView.delegate = self.delegate
        }
        self.collectionView.reloadData()
    }
    
    public func registerClass() {
        for section in sections {
            if let header = section.header, header.identifier.count > 0 {
                self.collectionView.register(header.anyClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.identifier)
            }
            if let footer = section.footer, footer.identifier.count > 0 {
                self.collectionView.register(footer.anyClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footer.identifier)
            }
            for cell in section.cells {
                self.collectionView.register(cell.anyClass, forCellWithReuseIdentifier: cell.identifier)
            }
        }
    }
    
    
}

public protocol CollectionContentView {
    var size:CGSize { get set }
    @discardableResult
    func size(_ size:CGSize) -> Self
}

struct CollectionContentViewKey {
    static var size = "size"
}

extension CollectionContentView {
    public var size:CGSize {
        get {
            objc_getAssociatedObject(self, &CollectionContentViewKey.size) as? CGSize ?? CGSize(width: -1, height: -1)
        }
        set {
            objc_setAssociatedObject(self, &CollectionContentViewKey.size, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @discardableResult
    public func size(_ size:CGSize) -> Self {
        var view = self
        view.size = size
        return view
    }
}
