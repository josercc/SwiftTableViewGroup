---
typora-copy-images-to: ../SwiftTableViewGroup/images/
typora-root-url: ../SwiftTableViewGroup
---

# SwiftTableViewGroup

> ❇️`SwiftTableViewGroup`is developed using the syntax of the latest Swift5.1``@_functionBuilder` combined with the latest `SwiftUI` design pattern.
>
> ❇️`SwiftTableViewGroup`是利用最新的`Swift.1`语法`@_functionBuilder`符合`SwiftUI`设计的数据驱动。

[TOC]

## 代码例子

![Snipaste_2019-07-29_14-11-01](/images/Snipaste_2019-07-29_14-11-01-4381583.png)

![Snipaste_2019-07-29_14-13-30](/images/Snipaste_2019-07-29_14-13-30.png)

![Snipaste_2019-07-29_14-18-03](/images/Snipaste_2019-07-29_14-18-03.png)



![Snipaste_2019-07-29_14-19-23](/images/Snipaste_2019-07-29_14-19-23.png)

## ChangeLog(更新记录)

### v2.0.0

- Support `UICollectionView` data driver(支持`UICollectionView`数据驱动)
- Changing `Api` is easier to use(更改`Api`使用更简单)
- Support for custom height or size(支持自定义高度或者大小)
- Safer to use(使用更加安全)

## 安装

### Swift Package Manager(Xcode 11)

```ruby
https://github.com/josercc/SwiftTableViewGroup
```

### CocoaPods

```swift
pod 'SwiftTableViewGroup'
```

### Carthage

```ruby
github "josercc/SwiftTableViewGroup"
```

## Claim(要求)

- `Xcode11`
- `Swift5.1`

## How to use(怎么使用)

### UITableView

#### Fake code(伪代码)

```swift
let tableView = UITableView()
var dataSource = TableView(tableView:tableView)
/// setup configuration(初始化配置)
dataSource.setup {
  /// Add Header
  TableViewHeaderFooterView
  /// Add Cell
  TableViewCell
  /// Add More Cell
  ...
  /// Add Footer
  TableViewHeaderFooterView
}
/// Perform registration and refresh(执行注册和刷新)
dataSource.reloadData
```

#### Create a static text list(创建一个简单的列表)

```swift
TableCell { content, contentCell in
    /// Create a configured block(创建配置的 Block)
    content.configuration(UITableViewCell.self) { (cell, index) in
        cell.textLabel?.text = self.source[index]
        cell.accessoryType = .disclosureIndicator
    }
    /// Create a clickback call block(创建点击回调 Block)
    content.didSelectRow(UITableViewCell.self) { (cell, index) in
    }
}
.number(self.source.count)
.height(45)
}
self.dataSource.reloadData()
```

![image-20190726143607274](/images/2019-07-26-063607.png)

#### Create complex TableView(创建复杂的表格)

```swift
let settingDataSource = TableView(tableView: tableView)
settingDataSource.setup {
  	/// Create `SettingHeaderView` Header(创建自定义`SettingHeaderView`Header)
    TableHeaderView(SettingHeaderView.self, { content,contentHeader in
        content.configuration(SettingHeaderView.self) { (view, section) in
            view.textLabel?.text = "Header"
        }
    })
    .height(49)
		/// Create `IntrinsicContentTextLabelCell` Cell(创建`IntrinsicContentTextLabelCell`Cell)
    TableCell(IntrinsicContentTextLabelCell.self)
  	/// Create Dynamic change number Cell(创建动态更改数量的 Cell)
    TableCell { content,contentCell in
        content.configuration(UITableViewCell.self) { (cell, index) in
            cell.textLabel?.text = "\(index) 点击我会增加哦"
        }
        content.didSelectRow(UITableViewCell.self) { (cell, index) in
            let number = contentCell.number + 1;
            contentCell.number(number)
            settingDataSource.reloadData()
        }
    }
    .height(44)
  	/// Create Dynamic change height Cell）(创建动态更改高度的 Cell)
    TableCell { content,contentCell in
        content.configuration(UITableViewCell.self) { (cell, index) in
            cell.textLabel?.text = "点击我改变高度"
        }
        content.didSelectRow(UITableViewCell.self) { (cell, index) in
            let height = contentCell.height == 44 ? 100 : 44;
            contentCell.height(CGFloat(height))
            settingDataSource.reloadData()
        }
    }
    .height(44)
}
```

![image-20190726143714253](/images/image-20190726143714253.png)

##### Dynamic change quantity(动态更改数量)

![image-20190726145544399](/images/image-20190726145544399.png)

##### Dynamic height(动态修改高度)

![image-20190726145605726](/images/image-20190726145605726.png)

### UICollectionView

```swift
self.dataSource.setup {
  	/// Create normal class `UICollectionViewCell` cell(创建默认为`UITableViewCell`类的 Cell)
    CollectionCell { content, cellContent in
        content.configuration(UICollectionViewCell.self) { (cell, index) in
            cell.backgroundColor = index % 2 == 0 ? UIColor.red : UIColor.blue
        }
        content.didSelectRow(UICollectionViewCell.self) { (cell, index) in
            cell.backgroundColor = cell.backgroundColor == UIColor.red ? UIColor.blue : 		UIColor.red
        }
    }
    .number(20)
    .size(CGSize(width: 100, height: 200))

}
.inset(UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
self.dataSource.reloadData()
```

![image-20190729105419637](/images//image-20190729105419637.png)

## Problem

### ❓How to dynamically insert or delete some elements(怎么动态的插入或者删除一组元素)

> You can change the element properties of the opposite side of the TableView's Sections array and then call `reloadData`.(您可以更改TableView的Sections数组的另一侧的元素属性，然后调用`reloadData`。)

### ❓How to listen to other agents of `UIScrollView`(怎么监听`UIScrollView`其他代理方法)

```swift
public struct ScrollViewDelegate {
    public var scrollViewDidScroll:((_ scrollView: UIScrollView) -> Void)?
    public var scrollViewWillBeginDragging:((_ scrollView: UIScrollView) -> Void)?
    public var scrollViewWillEndDragging:((_ scrollView: UIScrollView, _ velocity: CGPoint, _ targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void)?
    public var scrollViewDidEndDragging:((_ scrollView: UIScrollView, _ decelerate: Bool) -> Void)?
    public var scrollViewWillBeginDecelerating:((_ scrollView: UIScrollView) -> Void)?
    public var  scrollViewDidEndDecelerating:((_ scrollView: UIScrollView) -> Void)?
}

```

> Can implement the above proxy method of `UITableView`(可以实现`UITableView的上述代理方法)

Example

```swift
tableView.scrollDelegate?.scrollViewDidScroll = { scrollView in
}
```

### I feel that there are too few supported features.(我觉得支持的功能太少了。)

> Can submit PR or commit ISSUSE(可以提交PR或提ISSUSE)

## Api Document(Api 文档)

- Height or size setting priority (高度或者大小的设置优先级)
  - height( UITableViewCell/UITableHeaderFooterView)(高度( UITableViewCell/UITableHeaderFooterView))
    - custom > setting > auto(sizeToFit)(自定义 > 设置 > 自动获取(sizeToFit))
  - size(UICollectionViewCell/UICollectionReusableView)(大小(UICollectionViewCell/UICollectionReusableView))
    - custom > setting > FlowLayout(自定义 > 设置 > FlowLayout)

## contact me

- Email: josercc@163.com
