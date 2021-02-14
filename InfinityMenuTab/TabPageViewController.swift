//
//  TabPageViewController.swift
//  InfinityMenuTab
//
//  Created by 東原与生 on 2021/02/06.
//

import Foundation
import UIKit

class TabPageViewController: UIPageViewController {
        
    private let pageTabItems: [String] = [
        "demo-1",
        "demo-2",
        "demo-3",
        "demo-4",
        "demo-5",
        "demo-6",
        "demo-7",
        "demo-8",
        "demo-9",
        "demo-10",
    ]
    
    private var beforeIndex: Int = 0
    private var currentIndex: Int? {
        guard let viewController = viewControllers?.first else {
            return nil
        }
        return pageViewControllers.firstIndex(of: viewController)
    }
    var pageViewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初期化処理など
        
        dataSource = self
        delegate = self
        
        setViewControllers(
            [pageViewControllers[0]],
            direction: .forward,
            animated: false,
            completion: nil)
    }
    
    func configureMenuBar() {
        
        let tabView = InfinityMenuTabView()
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = NSLayoutConstraint(item: tabView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1.0,
                                        constant: tabView.tabViewHeight)
        
        tabView.addConstraint(height)
        view.addSubview(tabView)
        
        let top = NSLayoutConstraint(item: tabView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: topLayoutGuide.bottomAnchor,
                                     attribute: .bottom,
                                     multiplier:1.0,
                                     constant: 0.0)
        
        let left = NSLayoutConstraint(item: tabView,
                                      attribute: .leading,
                                      relatedBy: .equal,
                                      toItem: view,
                                      attribute: .leading,
                                      multiplier: 1.0,
                                      constant: 0.0)
        
        let right = NSLayoutConstraint(item: view,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: tabView,
                                       attribute: .trailing,
                                       multiplier: 1.0,
                                       constant: 0.0)
        
        view.addConstraints([top, left, right])
        
        tabView.pageTabItems = pageTabItems
    }
}


// MARK: - UIPageViewControllerDataSource

extension TabPageViewController: UIPageViewControllerDelegate {
    
}

extension TabPageViewController: UIPageViewControllerDataSource {
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        
        if index < 0 {
            index = pageViewControllers.count - 1
        } else if index == pageViewControllers.count {
            index = 0
        }
        
        if index >= 0 && index < pageViewControllers.count {
            return pageViewControllers[index]
        }
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController: viewController, isAfter: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController: viewController, isAfter: true)
    }
}
