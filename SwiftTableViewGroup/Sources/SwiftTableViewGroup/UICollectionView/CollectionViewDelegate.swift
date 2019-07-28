//
//  CollectionViewDelegate.swift
//  
//
//  Created by 张行 on 2019/7/16.
//

import UIKit

public class CollectionViewDelegate : NSObject {
    public var dataSource:CollectionView
    init(dataSource:CollectionView) {
        self.dataSource = dataSource
    }
}

extension CollectionViewDelegate : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = self.dataSource.sections[section]
        return section.number();
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.dataSource.sections[indexPath.section]
        let cellTuple = section.cell(index: indexPath.row)
        let collectionCell = cellTuple.cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.identifier, for: indexPath)
        collectionCell.makeConfig(view: cell, index: cellTuple.index)
        return cell
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionSection = self.dataSource.sections[indexPath.section]
        if kind == UICollectionView.elementKindSectionHeader, let header = collectionSection.header {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header.identifier, for: indexPath)
        } else if kind == UICollectionView.elementKindSectionFooter, let footer = collectionSection.footer {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footer.identifier, for: indexPath)
        }
        return UICollectionReusableView()
    }
}

extension CollectionViewDelegate : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionSection = self.dataSource.sections[indexPath.section]
        let cellTuple = collectionSection.cell(index: indexPath.row)
        let collectionCell = cellTuple.cell
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        collectionCell.makeDidSelectRow(view: cell, index: cellTuple.index)
        collectionView.deselectItem(at: indexPath, animated: true)
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

extension CollectionViewDelegate : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionSection = self.dataSource.sections[indexPath.section]
        let cellTuple = collectionSection.cell(index: indexPath.row)
        let collectionCell = cellTuple.cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell.identifier, for: indexPath)
        let customSize = collectionCell.makeCustomSize(view: cell, index: cellTuple.index)
        if customSize != CGSize(width: -1, height: -1) {
            return customSize
        } else if collectionCell.size != CGSize(width: -1, height: -1) {
            return collectionCell.size
        } else if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.itemSize
        } else {
            return CGSize.zero
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let block = self.dataSource.insetBlock {
            return block(section)
        } else if self.dataSource.inset != UIEdgeInsets.zero {
            return self.dataSource.inset
        } else if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            return flowLayout.sectionInset
        } else {
            return UIEdgeInsets.zero
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let block = self.dataSource.minimumLineSpacingBlock {
            return block(section)
        } else if self.dataSource.minimumLineSpacing != 0 {
            return self.dataSource.minimumLineSpacing
        } else if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            return flowLayout.minimumLineSpacing
        } else {
            return 0
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let block = self.dataSource.minimumInteritemSpacingBlock {
            return block(section)
        } else if self.dataSource.minimumInteritemSpacing != 0 {
            return self.dataSource.minimumInteritemSpacing
        } else if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            return flowLayout.minimumInteritemSpacing
        } else {
            return 0
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionSection = self.dataSource.sections[section]
        guard let header = collectionSection.header else {
            return CGSize.zero
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.identifier, for: IndexPath(row: 0, section: section))
        let customSize = header.makeCustomSize(view: headerView, index: section)
        if customSize != CGSize(width: -1, height: -1) {
            return customSize
        } else if header.size != CGSize(width: -1, height: -1) {
            return header.size
        } else {
            header.makeConfig(view: headerView, index: section)
            return headerView.sizeThatFits(CGSize.zero)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let collectionSection = self.dataSource.sections[section]
        guard let footer = collectionSection.footer else {
            return CGSize.zero
        }
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footer.identifier, for: IndexPath(row: 0, section: section))
        let customSize = footer.makeCustomSize(view: footerView, index: section)
        if customSize != CGSize(width: -1, height: -1) {
            return customSize
        } else if footer.size != CGSize(width: -1, height: -1) {
            return footer.size
        } else {
            footer.makeConfig(view: footerView, index: section)
            return footerView.sizeThatFits(CGSize.zero)
        }
    }
}
