//
//  HomeViewController.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation
import SwiftyJSON

let HomeCellIdentifier = "HomeCellIdentifier"

class HomeViewController: BaseViewController {
	
	var dataArray: Array<Singer>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
	}
	
	// MARK:- func
    @objc func refreshAction() {
        getSingerData()
    }
    
    func getSingerData() {
		NetworkAPIRequest.request(.artist) { (result) in
            switch result {
            case .success(let response):
                let jsonObj = try? JSON(data: response.data)
//                debugPrint("RECEIPT RESULT: ", jsonObj as Any)
                if let result = jsonObj?["result"].bool {
                    if result {
                        let singer_items = jsonObj!["singer_items"].rawString() ?? ""
                        let decoder = JSONDecoder()
                        do {
                            let singerItems = try decoder.decode([Singer].self, from: singer_items.data(using: .utf8)!)
                            self.dataArray = singerItems
                            self.tableView.reloadData()
                            self.tableView.mj_header?.endRefreshing()
                        } catch {
                            debugPrint("---- \(error)")
                        }
                    } else {
                        // 请求失败
                    }
                }
			case .failure(let error):
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
        
        t.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshAction))
        t.mj_header?.beginRefreshing()
        
        return t
    }()
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellIdentifier, for: indexPath) as! SingerTableViewCell
        cell.singer = self.dataArray?[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = SingerDetailViewController()
        let singer = self.dataArray?[indexPath.row]
        detailVC.singer = singer
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        
        debugPrint("---- \(indexPath) --- \(String(describing: singer))")
    }
}
