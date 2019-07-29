//
//  TableBuilder.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UITableViewHeaderFooterView

@_functionBuilder
public struct TableBuilder {
    public static func buildBlock(_ nodes:DataNode...) -> DataNode {
        var group = TableSectionGroup()
        if let _ = nodes.first as? TableSection {
            for node in nodes {
                if let section = node as? TableSection {
                    group.sections.append(section)
                }
            }
        } else {
            let section = TableSection {
                TableSectionBuilder.tableSection(nodes: nodes)
            }
            group.sections.append(section)
        }
        return group
    }
    
    
}


@_functionBuilder
public struct TableSectionBuilder {
    public static func buildBlock<Content:ViewRegister>(_ contents:Content...) -> DataNode {
        return self.tableSection(nodes: contents)
    }
    
    public static func tableSection(nodes:[DataNode]) -> TableViewRegiterGroup {
            var header:TableHeaderView?
            var footer:TableFooterView?
            var cells:[TableCell] = [TableCell]()
            for node in nodes {
                if let _header = node as? TableHeaderView {
                    header = _header
                } else if let _footer = node as? TableFooterView {
                    footer = _footer
                } else if let cell = node as? TableCell {
                    cells.append(cell)
                }
            }
            
            return TableViewRegiterGroup(header: header, footer: footer, cells: cells)
    }
}
