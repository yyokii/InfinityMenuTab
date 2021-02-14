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
        }
    }
    
    class func cellIdentifier() -> String {
        return "MenuCollectionCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setHeight(height: CGFloat) {
        baseView.heightAnchor.constraint(equalToConstant: height).isActive = true
        titleLabel.sizeToFit()
        baseView.widthAnchor.constraint(equalToConstant: titleLabel.frame.width).isActive = true
        
    }
}

// MARK: - IBAction

extension MenuCollectionCell {
    @IBAction fileprivate func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonTappedAction?()
    }
}
