//
//  HomeViewController.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation
import SwiftyJSON

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
                let jsonObj = try? JSON(data: response.data)
                debugPrint("RECEIPT RESULT: ", jsonObj as Any)
                if let result = jsonObj?["result"].bool {
                    if result {
                        let singer_items = jsonObj!["singer_items"].rawString() ?? ""
                        let decoder = JSONDecoder()
                        do {
                            let singerItems = try decoder.decode([Singer].self, from: singer_items.data(using: .utf8)!)
                            self.dataArray = singerItems
                            
                        } catch {
                            debugPrint("---- \(error)")
                        }
                    } else {
                        // 请求失败
                    }
                }
			case let .failure(error):
				debugPrint(error)
			}
		}
	}
	
	// MARK:- getter
	
	
}
