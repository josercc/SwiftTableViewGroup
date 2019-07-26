//
//  UIScrollView+Delegate.swift
//  
//
//  Created by 张行 on 2019/7/17.
//

import UIKit.UIScrollView

extension UIScrollView {
    public var scrollDelegate:ScrollViewDelegate? {
        get {
            return objc_getAssociatedObject(self, "scrollDelegate") as? ScrollViewDelegate
        }
        set {
            objc_setAssociatedObject(self, "scrollDelegate", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public struct ScrollViewDelegate {
    public var scrollViewDidScroll:((_ scrollView: UIScrollView) -> Void)?
    public var scrollViewWillBeginDragging:((_ scrollView: UIScrollView) -> Void)?
    public var scrollViewWillEndDragging:((_ scrollView: UIScrollView, _ velocity: CGPoint, _ targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void)?
    public var scrollViewDidEndDragging:((_ scrollView: UIScrollView, _ decelerate: Bool) -> Void)?
    public var scrollViewWillBeginDecelerating:((_ scrollView: UIScrollView) -> Void)?
    public var  scrollViewDidEndDecelerating:((_ scrollView: UIScrollView) -> Void)?
}
