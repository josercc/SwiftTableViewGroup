//
//  NormalCollectionViewController.swift
//  SwiftTableViewGroupApp
//
//  Created by zhang hang on 2019/7/27.
//  Copyright © 2019 张行. All rights reserved.
//

import UIKit
import SnapKit
import SwiftTableViewGroup

class NormalCollectionViewController: UIViewController {
    lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        return flowLayout
    }()
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var dataSource : CollectionView = {
        let dataSource = CollectionView(collectionView: self.collectionView)
        return dataSource
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.zero)
        }
        self.dataSource.setup {
            CollectionCell { content, cellContent in
                content.configuration(UICollectionViewCell.self) { (cell, index) in
                    cell.backgroundColor = index % 2 == 0 ? UIColor.red : UIColor.blue
                }
                content.didSelectRow(UICollectionViewCell.self) { (cell, index) in
                    cell.backgroundColor = cell.backgroundColor == UIColor.red ? UIColor.blue : UIColor.red
                }
            }
            .number(20)
            .size(CGSize(width: 100, height: 200))
            
        }
        .inset(UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        self.dataSource.reloadData()
    }
}
