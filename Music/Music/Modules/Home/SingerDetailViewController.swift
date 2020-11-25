//
//  SingerDetailViewController.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit
import SwiftyJSON

let SingerDatailCellIdentifier = "SingerDatailCellIdentifier"
class SingerDetailViewController: BaseViewController {
    
    var singer: Singer?
    var mvsArray: [Playlist]?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = singer?.name
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK:- Func
    func getMvsData() {
        NetworkAPIRequest.request(.artistdetail(singer_id: self.singer?.id ?? "")) { (result) in
            switch result {
            case .success(let response):
                let jsonObj = try? JSON(data: response.data)
                debugPrint(jsonObj as Any)
                // ["playlist_items"]
                if let result = jsonObj?["result"].bool {
                    if result {
                        let playlist_items = jsonObj!["playlist_items"].rawString() ?? ""
                        let decoder = JSONDecoder()
                        do {
                            let playlists = try decoder.decode([Playlist].self, from: playlist_items.data(using: .utf8)!)
                            self.mvsArray = playlists
                            self.singer?.playlists = playlists
                            
                            // 写入数据库
                            let result = PlaylistDao.addPlaylist(singer: self.singer ?? nil)
                            debugPrint(result)
                            
                            self.tableView.reloadData()
                        } catch {
                            debugPrint("---- \(error)")
                        }
                        
                        self.tableView.mj_header?.endRefreshing()
                    } else {
                        // 请求失败
                    }
                }
                
            case .failure(let error):
                debugPrint(error)
                self.mvsArray = PlaylistDao.getPlaylist(with: self.singer?.id ?? "")
                self.singer?.playlists = self.mvsArray
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    @objc func refreshAction() {
        getMvsData()
    }
    
    // MARK:- Other
    
    // MARK:- Setter
    
    // MARK:- LazyInit
    lazy var headerView: UIView = {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 120))
        
        let cover = UIImageView()
        header.addSubview(cover)
        cover.layer.cornerRadius = 50
        cover.clipsToBounds = true
        cover.contentMode = .scaleAspectFill
        cover.backgroundColor = UIColor.withRandom()
        cover.kf.setImage(with: URL(string: self.singer?.img_url ?? ""))
        cover.autoSetDimensions(to: CGSize(width: 100, height: 100))
        cover.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        cover.autoAlignAxis(.horizontal, toSameAxisOf: header)
        
        let name = UILabel()
        header.addSubview(name)
        name.text = self.singer?.name
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18)
        name.autoPinEdge(.left, to:.right , of: cover, withOffset: 15)
        name.autoAlignAxis(.horizontal, toSameAxisOf: header)
        
        return header
    }()
    
    // MARK:- getter
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.rowHeight = 80
        t.backgroundColor = .clear
        t.tableFooterView = UIView()
        t.register(SingerDetailTableViewCell.self, forCellReuseIdentifier: SingerDatailCellIdentifier)
        t.tableHeaderView = self.headerView
        
        t.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshAction))
        t.mj_header?.beginRefreshing()
        
        return t
    }()
}

extension SingerDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mvsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingerDatailCellIdentifier, for: indexPath) as! SingerDetailTableViewCell
        cell.detail = self.mvsArray?[indexPath.row]
        return cell
    }
}

extension SingerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("---- \(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = MvDetailViewController()
        detailVC.playlist = self.mvsArray?[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
