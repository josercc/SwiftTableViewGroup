
# OC 版本请移步[这里](https://github.com/josercc/ZHTableViewGroup)
# ZHTableViewGroup为 UITableView 而生

![](http://olg3v8vew.bkt.clouddn.com/2017-03-16-38.gif)

## 怎么安装

```ruby
pod 'ZHTableViewGroupSwift'
```



### 怎么使用

1. ### 初始化 ZHTableViewDataSource

   ```swift
   var dataSource:ZHTableViewDataSource?
   self.dataSource = ZHTableViewDataSource(tableView: self.tableView)
   ```

2. ### 初始化 ZHTableViewGroup 

   ```swift
   self.dataSource?.addGroup(completionHandle: { (group) in
   	//code
   }
   ```

3. ### 初始化 ZHTableViewCell

   ```swift
   group.addCell(completionHandle: { (cell) in
   	//code
   }
   ```

4. ### 配置 ZHTableViewCell

   ```swift
     cell.anyClass = UITableViewCell.self
     cell.cellNumber = self.cellTexts.count
     cell.identifier = "UITableViewCellIdentifier"
     cell.setConfigCompletionHandle(configCompletionHandle: { (cell, indexPath) in
         let string = self.cellTexts[indexPath.row]
         cell.textLabel?.text = string
         if self.selectTitles.contains(string) {
             cell.accessoryType = .checkmark
         } else {
             cell.accessoryType = .none
         }
     })
     cell.setDidSelectRowCompletionHandle(didSelectRowCompletionHandle: { (cell, indexPath) in
         let string = self.cellTexts[indexPath.row]
         if self.selectTitles.contains(string) {
             guard let index = self.selectTitles.index(of: string) else {
                 return
             }
             self.selectTitles.remove(at: index)
         } else {
             self.selectTitles.append(string)
         }
         self.tableView.reloadData()
     })
   ```

5. ### 配置 UITableView的代理

   ```swift
       // 设置 UITableView 的组个数
       public override func numberOfSections(in tableView: UITableView) -> Int {
           return ZHTableViewDataSource.numberOfSections(dataSource: self.dataSource)
       }

       // 设置组 Cell 的个数
       public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return ZHTableViewDataSource.numberOfRowsInSection(dataSource: self.dataSource, section: section)
       }

       // 设置 Cell
       public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = ZHTableViewDataSource.cellForRowAt(dataSource: self.dataSource, indexPath: indexPath)
           cell.selectionStyle = .none
           return cell
       }

       public override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           ZHTableViewDataSource.didSelectRowAt(dataSource: self.dataSource, indexPath: indexPath)
       }
   ```

### 6 清除配置

```swift
self.dataSource?.clearData()
```
