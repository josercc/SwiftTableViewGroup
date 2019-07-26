//
//  TableViewDelegate.swift
//  
//
//  Created by 张行 on 2019/7/16.
//

import UIKit

public class TableViewDelegate : NSObject {
    public let dataSource:TableView
    init(dataSource:TableView) {
        self.dataSource = dataSource
    }
}

extension TableViewDelegate : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.dataSource.sections[section]
        return section.number();
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.dataSource.sections[indexPath.section]
        let cellTuple = section.cell(index: indexPath.row)
        let tableCell = cellTuple.cell
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell.identifier, for: indexPath)
        tableCell.makeCellConfig(cell: cell, index: cellTuple.index)
        return cell
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.sections.count
    }
}

extension TableViewDelegate : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.dataSource.sections[indexPath.section]
        let cellTuple = section.cell(index: indexPath.row)
        let tableCell = cellTuple.cell
        if tableCell.height != 0 {
            return tableCell.height
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCell.identifier) else {
                return 0
            }
            tableCell.makeCellConfig(cell: cell, index: cellTuple.index)
            return cell.sizeThatFits(CGSize(width: tableView.frame.width, height: 0)).height
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let tableSection = self.dataSource.sections[section]
        guard let header = tableSection.header else {
            return 0
        }
        if header.height != 0 {
            return header.height
        } else {
            guard let tableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.identifier) else {
                return 0
            }
            header.makeHeaderFooterConfig(headerFooter: tableHeader, section: section)
            return tableHeader.sizeThatFits(CGSize(width: tableView.frame.width, height: 0)).height
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let tableSection = self.dataSource.sections[section]
        guard let footer = tableSection.footer else {
            return 0
        }
        if footer.height != 0 {
            return footer.height
        } else {
            guard let tableFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.identifier) else {
                return 0
            }
            footer.makeHeaderFooterConfig(headerFooter: tableFooter, section: section)
            return tableFooter.sizeThatFits(CGSize(width: tableView.frame.width, height: 0)).height
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableSection = self.dataSource.sections[section]
        guard let header = tableSection.header else {
            return nil
        }
        guard let tableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.identifier) else {
            return nil
        }
        header.makeHeaderFooterConfig(headerFooter: tableHeader, section: section)
        return tableHeader
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tableSection = self.dataSource.sections[section]
        guard let footer = tableSection.footer else {
            return nil
        }
        guard let tableFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.identifier) else {
            return nil
        }
        footer.makeHeaderFooterConfig(headerFooter: tableFooter, section: section)
        return tableFooter
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableSection = self.dataSource.sections[indexPath.section]
        let cellTuple = tableSection.cell(index: indexPath.row)
        let tableCell = cellTuple.cell
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        tableCell.makeCellDidSelectRow(cell: cell, index: cellTuple.index)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollView.scrollDelegate?.scrollViewWillEndDragging?(scrollView,velocity, targetContentOffset)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.scrollDelegate?.scrollViewDidEndDragging?(scrollView, decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
}
