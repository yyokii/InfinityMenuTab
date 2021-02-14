//
//  ViewController.swift
//  InfinityMenuTab
//
//  Created by 東原与生 on 2021/02/06.
//

import UIKit

class ViewController: UIViewController {
    
    private var tabView: InfinityMenuTabView!
    
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
        "demo-10demo-10demo-10",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

    func configureView() {
        tabView = InfinityMenuTabView()
        tabView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabView)
        
        tabView.heightAnchor.constraint(equalToConstant: tabView.tabViewHeight).isActive = true
        tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        tabView.configureView()
        tabView.pageTabItems = pageTabItems
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabView.moveCurrentBarView(IndexPath(row: pageTabItems.count, section: 0), animated: false)
    }
}

