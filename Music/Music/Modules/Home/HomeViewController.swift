//
//  HomeViewController.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation

class HomeViewController: BaseViewController {
	
	var dataArray: Array<Any>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getSingerData()
	}
	
	// MARK:- func
	func getSingerData() {
		NetworkAPIRequest.request(.artist) { (result) in
			debugPrint(result)
			switch result {
			case let .success(response):
                
                if let model = try? response.map(String.self) {
                    debugPrint(model)
                } else {
                    debugPrint("singer_items decode failure")
                }
                
                if let model = try? response.map(Singer.self, atKeyPath: "singer_items") {
                    debugPrint(model)
                } else {
                    debugPrint("singer_items decode failure")
                }
                
//				let jsonObj = try? JSON(data: response.data)
//				debugPrint(jsonObj as Any)
//				if let ret = jsonObj?["ret"].int {
//					if ret == 200 {
//						// Handle Success
//						if jsonObj?["data"]["bindExists"].bool ?? false {
//							MBProgressHUD.showMessage(NSLocalizedString("The account has been bound by another user", comment: "v1.0.7"), withHideAfter: 1.5)
//							return
//						}
//
//						handleUserInfoAndGroupInfos(WithJSON: jsonObj!, successfulCompletion: { (userInfo, groupInfos, circleInfo) in
//							MBProgressHUD.showMessage(NSLocalizedString("Account binding successfully", comment: "v1.0.7"), withHideAfter: 1.5)
//
//							self.closeBtnDidClick()
//
//						}) {
//
//						}
//
//						return
//					} else {
//						// Handle Status Error
//
//					}
//				} else {
					// Handle Error
					
//				}
			case let .failure(error):
				debugPrint(error)
				// Handle Error
			}
		}
	}
	
	// MARK:- getter
	
	
}
