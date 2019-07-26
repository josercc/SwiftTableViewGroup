//
//  ViewRegister.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import CoreGraphics

public protocol ViewRegister: DataNode {
    var anyClass:AnyClass { get }
    var identifier: String { get }
    var height:CGFloat {get set}
    var number:Int {get set}
}

