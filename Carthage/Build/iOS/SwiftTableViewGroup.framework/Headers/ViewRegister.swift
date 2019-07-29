//
//  ViewRegister.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import CoreGraphics
import UIKit.UIView

public protocol ViewRegister: DataNode {
    var anyClass:AnyClass { get set}
    var identifier: String { get set}
    var number:Int {get set}
    @discardableResult
    func number(_ number:Int) -> Self
}

struct VeiwRegisterKey {
    static var number = "number"
}

extension ViewRegister {
    public var number: Int {
        get {
            objc_getAssociatedObject(self, &VeiwRegisterKey.number) as? Int ?? 1
        }
        set {
            objc_setAssociatedObject(self, &VeiwRegisterKey.number, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @discardableResult
    public func number(_ number:Int) -> Self {
        var view = self
        view.number = number
        return view
    }
}
