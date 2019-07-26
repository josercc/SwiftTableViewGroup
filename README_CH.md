---
typora-root-url: ../../../../../System/Volumes/Data/Users/zhangxing/Downloads/SwiftTableViewGroup
typora-copy-images-to: ../../../../../System/Volumes/Data/Users/zhangxing/Downloads/SwiftTableViewGroup/images
---

# SwiftTableViewGroup

> ❇️`SwiftTableViewGroup`是居于之前`ZHTableViewGroupSwift`利用最新的`Swift5.1`的`@_functionBuilder`的语法特性结合最新的`SwiftUI`的设计模式研发的。

## 演示

![image-20190726143607274](/images/2019-07-26-063607.png)

![image-20190726143633679](/images/2019-07-26-063634.png)

![image-20190726143714253](/images/image-20190726143714253.png)

## 安装

### Swift Package Manager(Xcode 11)

```shell
https://github.com/josercc/SwiftTableViewGroup
```

## 怎么使用

### 代码模板(非真正的代码)(Code template (not real code))

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

### 创建一个静态的文本列表(Create a static text list)

```swift
let source:[String] = [
    "普通的列表文本",
    "复杂的设置界面",
]
func steupTableView() {
        self.dataSource.setup {
          	/// 创建一个默认类型为 UITableViewCell 的 TableViewCell
            TableCell { (tableCell, blockType, cell, index) in
                /// 不执行这个方法就不会回调 Config 和 DidSlectRow回调
                tableCell.makeContentBlock(type: blockType,
                                           cell: cell,
                                           index: index,
                                           configContent: CellBlockContent<UITableViewCell> {(cell,index) in
                                            cell.textLabel?.text = source[index]
                                            cell.accessoryType = .disclosureIndicator
                    },
                                           didSelectRowContent: self.didSelectRowContent())
            }
         
            .number(source.count) /// 设置 Cell 的数量
            .height(45)
        }
        self.dataSource.reloadData()
    }
    ///config和 didSelectRow 的回调可以单独提出来防止代码太乱
    func didSelectRowContent() -> CellBlockContent<UITableViewCell> {
      	/// CellBlockContent的泛型必须和创建声明的类型一致 不然回调无法完成
        CellBlockContent<UITableViewCell> {(cell,index) in
        }
    }
```

![image-20190726143607274](/images/2019-07-26-063607.png)

### 创建复杂的界面

```swift
var settingDataSource = TableView(tableView: tableView)
settingDataSource.setup {
  	/// 创建一个 Header
    TableHeaderFooterView(SettingHeaderView.self, .header,{ (tableHeader, header, section) in
        tableHeader.makeContentBlock(headerFooter: header, section: section, configContent: HeaderFooterBlockContent<SettingHeaderView> {(header,section) in
            header.textLabel?.text = "Header"
        })
    })
    .height(49)
  	/// 创建一个自定义的 UITableViewCell 自动高度
    TableCell(IntrinsicContentTextLabelCell.self)
  	/// 创建一个默认的 UITableViewCell 动态变动数量
    TableCell { (tableCell, blockType, cell, index) in
        tableCell.makeContentBlock(type: blockType, cell: cell, index: index, configContent: CellBlockContent<UITableViewCell> {(cell,index) in
            cell.textLabel?.text = "\(index) 点击我会增加哦"
            }, didSelectRowContent: CellBlockContent<UITableViewCell> {(cell,index) in
                let number = tableCell.number + 1
                tableCell.number(number)
                settingDataSource.reloadData()
        })
    }
  	/// 创建一个默认的 UITableViewCell 动态变动高度
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

#### 动态变动数量

![image-20190726145544399](/images/image-20190726145544399.png)

#### 动态变动高度

![image-20190726145605726](/images/image-20190726145605726.png)

## 问题

### ❓怎么动态插入或者删除一些元素

> 可以拿到TableView 的 Sections 数组对立面的元素属性进行变更之后重新调用`reloadData`即可。

### ❓怎么监听`UIScrollView`的其他代理

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

> 可以实现`UITableView`的上面的代理方法

比如

```swift
tableView.scrollDelegate?.scrollViewDidScroll = { scrollView in
}
```

### 觉得支持的功能太少了

> 可以提交 PR 或者提 ISSUSE

## 联系我

- 邮箱: josercc@163.com