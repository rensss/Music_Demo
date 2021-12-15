//
//  BaseNavViewController.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation

class BaseNavViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
