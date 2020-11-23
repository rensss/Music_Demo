//
//  HomeViewController.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation
import SwiftyJSON


let HomeCellIdentifier = "SingerTableViewCell"

class HomeViewController: BaseViewController {
	
	var dataArray: Array<Any>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getSingerData()
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
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
                            self.tableView.reloadData()
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
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.rowHeight = 50
        t.backgroundColor = .clear
        t.tableFooterView = UIView()
        t.register(SingerTableViewCell.self, forCellReuseIdentifier: HomeCellIdentifier)
        return t
    }()
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellIdentifier, for: indexPath) as! SingerTableViewCell
        cell.singer = self.dataArray?[indexPath.row] as? Singer
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("---- \(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = SingerDetailViewController()
        detailVC.singer = self.dataArray?[indexPath.row] as? Singer
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
