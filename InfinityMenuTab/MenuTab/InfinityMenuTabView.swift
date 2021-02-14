//
//  InfinityTabView.swift
//  InfinityMenuTab
//
//  Created by 東原与生 on 2021/02/06.
//

import Foundation
import UIKit

class InfinityMenuTabView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentBarView: UIView!
    @IBOutlet weak var currentBarViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var flowLayout: UICollectionView!
    
    private var currentBarViewWidth: CGFloat = 0.0
    
    
    private var pageTabItemsWidth: CGFloat = 0.0
    var pageTabItems: [String] = [] {
        didSet {
            // collectionView.reloadData()
        }
    }
    
    let tabViewHeight: CGFloat = 70
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    func configureView() {
        let bundle = Bundle(for: MenuCollectionCell.self)
        let nib = UINib(nibName: MenuCollectionCell.cellIdentifier(), bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: MenuCollectionCell.cellIdentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.scrollsToTop = false
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func deselectVisibleCells() {
        collectionView
            .visibleCells
            .compactMap { $0 as? MenuCollectionCell }
            .forEach { $0.isCurrent = false }
    }
    
    func moveCurrentBarView(_ indexPath: IndexPath, animated: Bool) {
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        layoutIfNeeded()
        currentBarViewWidth = 0.0
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionCell {
            currentBarView.isHidden = false
            cell.isCurrent = true
            currentBarViewWidthConstraint.constant = cell.frame.width
            
            cell.isCurrent = true
        }
    }
}

extension InfinityMenuTabView: UICollectionViewDelegate {
    
}

extension InfinityMenuTabView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageTabItems.count * 3 // 表示したい要素数の3倍を返す
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionCell.cellIdentifier(), for: indexPath) as! MenuCollectionCell
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configureCell(cell: MenuCollectionCell, indexPath: IndexPath) {
        
        // 無限スクロールのために要素数を3倍用意しているので要素群のindexを計算します
        let fixedIndex = indexPath.item % pageTabItems.count
        cell.title = pageTabItems[fixedIndex]
        cell.tabItemButtonTappedAction = { [weak self] in
            
            guard let self = self else { return }
            self.moveCurrentBarView(indexPath, animated: true)
        }
    }
}

extension InfinityMenuTabView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if pageTabItemsWidth == 0.0 {
            pageTabItemsWidth = floor(scrollView.contentSize.width / 3.0) // 表示したい要素"群"のwidthを計算
        }
        
        if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > pageTabItemsWidth * 2.0) { // スクロールした位置がしきい値を超えたら中央に戻す
            scrollView.contentOffset.x = pageTabItemsWidth
        }
    }
}
