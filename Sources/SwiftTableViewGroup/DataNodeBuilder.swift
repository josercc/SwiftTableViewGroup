//
//  DataNodeBuilder.swift
//  
//
//  Created by 张行 on 2019/7/16.
//

/// 数据源组装对象
@_functionBuilder
public struct DataNodeBuilder {
    public static func buildBlock(_ groups:DataNode...) -> DataNode {
        return Group(nodes: groups)
    }
}

