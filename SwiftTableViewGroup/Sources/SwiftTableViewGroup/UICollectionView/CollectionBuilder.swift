//
//  CollectionBuilder.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UICollectionView

@_functionBuilder
public struct CollectionBuilder {
    public static func buildBlock(_ nodes:DataNode...) -> DataNode {
        var group = CollectionSectionGroup()
        if let _ = nodes.first as? CollectionSection {
            for node in nodes {
                if let section = node as? CollectionSection {
                    group.sections.append(section)
                }
            }
        } else {
            let section = CollectionSection {
                CollectionSectionBuilder.collectionSection(nodes: nodes)
            }
            group.sections.append(section)
        }
        return group
    }
    
    
}


@_functionBuilder
public struct CollectionSectionBuilder {
    public static func buildBlock<Content:ViewRegister>(_ contents:Content...) -> DataNode {
        return self.collectionSection(nodes: contents)
    }
    
    public static func collectionSection(nodes:[DataNode]) -> CollectionViewRegiterGroup {
            var header:CollectionHeaderView?
            var footer:CollectionFooterView?
            var cells:[CollectionCell] = [CollectionCell]()
            for node in nodes {
                if let _header = node as? CollectionHeaderView {
                    header = _header
                } else if let _footer = node as? CollectionFooterView {
                    footer = _footer
                } else if let cell = node as? CollectionCell {
                    cells.append(cell)
                }
            }
            
            return CollectionViewRegiterGroup(header: header, footer: footer, cells: cells)
    }
}
