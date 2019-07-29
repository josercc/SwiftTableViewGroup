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
        return realValue(zero: CGSize.zero,
                         custom: { () -> CGSize in
            return collectionCell.makeCustomSize(index: cellTuple.index)
        }, setting: { () -> CGSize in
            return collectionCell.size
        }, layout: { () -> CGSize in
            let size = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize
            return size ?? CGSize.zero
        }) { () -> CGSize in
            return CGSize.zero
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return realValue(zero: UIEdgeInsets.zero,
                         custom: { () -> UIEdgeInsets in
            return self.dataSource.insetBlock?(section) ?? UIEdgeInsets.zero
        }, setting: { () -> UIEdgeInsets in
            return self.dataSource.inset
        }, layout: { () -> UIEdgeInsets in
            return (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? UIEdgeInsets.zero
        }) { () -> UIEdgeInsets in
            return UIEdgeInsets.zero
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return realValue(zero: CGFloat(0),
                         custom: { () -> CGFloat in
                            return self.dataSource.minimumLineSpacingBlock?(section) ?? CGFloat(0)
        }, setting: { () -> CGFloat in
            return self.dataSource.minimumLineSpacing
        }, layout: { () -> CGFloat in
            return (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? CGFloat(0)
        }) { () -> CGFloat in
            return CGFloat(0)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return realValue(zero: CGFloat(0),
                         custom: { () -> CGFloat in
            return self.dataSource.minimumInteritemSpacingBlock?(section) ?? CGFloat(0)
        }, setting: { () -> CGFloat in
            return self.dataSource.minimumInteritemSpacing
        }, layout: { () -> CGFloat in
            return (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? CGFloat(0)
        }) { () -> CGFloat in
            return CGFloat(0)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionSection = self.dataSource.sections[section]
        guard let header = collectionSection.header else {
            return CGSize.zero
        }
        return realValue(zero: CGSize.zero,
                         custom: { () -> CGSize in
            return header.makeCustomSize(index: section)
        }, setting: { () -> CGSize in
            return header.size
        }, layout: { () -> CGSize in
            return (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? CGSize.zero
        }) { () -> CGSize in
            return CGSize.zero
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let collectionSection = self.dataSource.sections[section]
        guard let footer = collectionSection.footer else {
            return CGSize.zero
        }
        return realValue(zero: CGSize.zero,
                         custom: { () -> CGSize in
            return footer.makeCustomSize(index: section)
        }, setting: { () -> CGSize in
            return footer.size
        }, layout: { () -> CGSize in
            return (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? CGSize.zero
        }) { () -> CGSize in
            return CGSize.zero
        }
    }
    
    
}
