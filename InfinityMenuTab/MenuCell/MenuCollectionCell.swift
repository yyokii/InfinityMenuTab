//
//  MenuCollectionCell.swift
//  InfinityMenuTab
//
//  Created by 東原与生 on 2021/02/07.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    var tabItemButtonTappedAction: (() -> Void)?
    
    var isCurrent = false {
        didSet {
            //            currentBarView.isHidden = !isCurrent
            if isCurrent {
                //                highlightTitle()
            } else {
                //                unHighlightTitle()
            }
            //            currentBarView.backgroundColor = option.currentColor
            //            layoutIfNeeded()
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
            titleLabel.invalidateIntrinsicContentSize()
            invalidateIntrinsicContentSize()
        }
    }
    
    class func cellIdentifier() -> String {
        return "MenuCollectionCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if title.count == 0 {
            return CGSize.zero
        }

        return intrinsicContentSize
    }
    
    override var intrinsicContentSize : CGSize {
        let width = titleLabel.intrinsicContentSize.width
        let size = CGSize(width: width, height: 70)
        return size
    }
}

// MARK: - IBAction

extension MenuCollectionCell {
    @IBAction fileprivate func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonTappedAction?()
    }
}
