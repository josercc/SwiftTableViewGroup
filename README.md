---
typora-root-url: ../SwiftTableViewGroup
---

# SwiftTableViewGroup

# [🇨🇳(中文)](./README_CH.md)

> ❇️`SwiftTableViewGroup` is the previous one. ZHTableViewGroupSwift` is developed using the syntax of the latest `Swift5.1` `@_functionBuilder` combined with the latest `SwiftUI` design pattern.

[TOC]



## Demo

![image-20190726143607274](/images/2019-07-26-063607.png)

![image-20190726143633679](/images/2019-07-26-063634.png)

![image-20190726143714253](/images/image-20190726143714253.png)

![Simulator Screen Shot - iPhone Xʀ - 2019-07-27 at 21.43.43](/images/Simulator Screen Shot - iPhone Xʀ - 2019-07-27 at 21.43.43.png)

## 安装

### Swift Package Manager(Xcode 11)

```shell
https://github.com/josercc/SwiftTableViewGroup
```

## Claim

- `Xcode11`
- `Swift5.1`

## How to use

### Code template (not real code)

```swift
let tableView = UITableView()
var dataSource = TableView(tableView:tableView)
dataSource.setup {
  /// Header
  TableViewHeaderFooterView
  /// Cell
  TableViewCell
  /// Footer
  TableViewHeaderFooterView
}
dataSource.reloadData
```

### Create a static text list)

```swift
let source:[String] = [
    "Normal list text",
    "Complex setup interface",
]
func steupTableView() {
        self.dataSource.setup {
          	/// Create a TableViewCell with a default type of UITableViewCell
            TableCell { (tableCell, blockType, cell, index) in
                /// Calling Config and DidSlectRow callbacks without executing this method
                tableCell.makeContentBlock(type: blockType,
                                           cell: cell,
                                           index: index,
                                           configContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                            cell.textLabel?.text = source[index]
                                            cell.accessoryType = .disclosureIndicator
                    },
                                           didSelectRowContent: self.didSelectRowContent())
            }
         
            .number(source.count) /// Set the number of cells
            .height(45)
        }
        self.dataSource.reloadData()
    }
    ///The callbacks for config and didSelectRow can be raised separately to prevent the code from being messy
    func didSelectRowContent() -> CellBlockContent<UITableViewCell> {
      	/// The generic type of CellBlockContent must match the type of the created declaration. Otherwise, the callback cannot be completed.
        CellBlockContent<UITableViewCell> {(cell,index) in
        }
    }
```

![image-20190726143607274](/images/2019-07-26-063607.png)

### Create complex interfaces

```swift
var settingDataSource = TableView(tableView: tableView)
settingDataSource.setup {
  	/// Create a Header
    TableHeaderFooterView(SettingHeaderView.self, .header,{ (tableHeader, header, section) in
        tableHeader.makeContentBlock(headerFooter: header, section: section, configContent: HeaderFooterBlockContent<SettingHeaderView> {(header,section) in
            header.textLabel?.text = "Header"
        })
    })
    .height(49)
  	/// Create a custom UITableViewCell automatic height
    TableCell(IntrinsicContentTextLabelCell.self)
  	/// Create a default UITableViewCell dynamic change quantity
    TableCell { (tableCell, blockType, cell, index) in
        tableCell.makeContentBlock(type: blockType, cell: cell, index: index, configContent: CellBlockContent<UITableViewCell> {(cell,index) in
            cell.textLabel?.text = "\(index) 点击我会增加哦"
            }, didSelectRowContent: CellBlockContent<UITableViewCell> {(cell,index) in
                let number = tableCell.number + 1
                tableCell.number(number)
                settingDataSource.reloadData()
        })
    }
  	/// Create a default UITableViewCell dynamic change height
    TableCell { (tableCell, blockType, cell, index) in
        tableCell.makeContentBlock(type: blockType,
                                   cell: cell,
                                   index: index,
                                   configContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                    cell.textLabel?.text = "点击我改变高度"
            },
                                   didSelectRowContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                    let height = tableCell.height == 44 ? 100 : 44;
                                    tableCell.height(CGFloat(height))
                                    settingDataSource.reloadData()
        })
    }
    .height(44)
}
```

![image-20190726143714253](/images/image-20190726143714253.png)

#### Dynamic change quantity

![image-20190726145544399](/images/image-20190726145544399.png)

#### Dynamic height

![image-20190726145605726](/images/image-20190726145605726.png)

## Problem

### ❓How to dynamically insert or delete some elements

> You can change the element properties of the opposite side of the TableView's Sections array and then call `reloadData`.

### ❓How to listen to other agents of `UIScrollView`

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

> Can implement the above proxy method of `UITableView`

Example

```swift
tableView.scrollDelegate?.scrollViewDidScroll = { scrollView in
}
```

### I feel that there are too few supported features.

> Can submit PR or mention ISSUSE

## contact me

- Email: josercc@163.com
