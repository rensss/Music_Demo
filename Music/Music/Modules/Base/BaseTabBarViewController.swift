//
//  BaseTabBarViewController.swift
//  Music
//
//  Created by Rzk on 2020/11/20.
//

import Foundation

class BaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let titles = ["Home","Setting"]
        let vcs = [HomeViewController(),SettingViewController()]
        
        var navs = [BaseNavViewController]()
        for i in 0 ..< 2 {
            let nav = BaseNavViewController.init(rootViewController: vcs[i])
            vcs[i].title = titles[i]
            nav.tabBarItem.title = titles[i]
            navs.append(nav)
        }
        self.viewControllers = navs
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.tintColor = UIColor.darkText
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Do any additional setup after loading the view.
    }
    
//      func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if let _ = ((viewController as? BaseNavViewController)?.viewControllers[0] as? UserCenterViewController){
//
//              if !HJ_UserInfo.shared.islogin {
//                let sb = UIStoryboard(name: "LoginStoryboard", bundle: nil)
//                let login = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
//                login.currentIndex = self.selectedIndex
//
//                let nav = BaseNavViewController.init(rootViewController: login)
//                nav.modalPresentationStyle = .fullScreen
//                currentViewController()?.present(nav, animated: true) {
//                      tabBarController.selectedViewController = viewController
//                }
//                return false
//              }
//
//        }else if viewController.tabBarItem.title == ""{
//              let vc = ScanCodeController.init()
//              let nav = BaseNavViewController.init(rootViewController: vc)
//              nav.modalPresentationStyle = .fullScreen
//              currentViewController()?.present(nav, animated: true) {
//
//              }
//              return false
//        }
//        return true
//      }
}
