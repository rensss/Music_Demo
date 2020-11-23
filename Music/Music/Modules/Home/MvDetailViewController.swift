//
//  MvDetailViewController.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit


let MvTableViewCellIdentifier = "MvTableViewCellIdentifier"

class MvDetailViewController: BaseViewController {
    
    var playlist: SingerDetail?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = playlist?.playlist_name
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        setupData()
    }
    
    // MARK:- Func
    func setupData() {
        self.tableView.reloadData()
    }
    
    // MARK:- LazyInit
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.rowHeight = 80
        t.backgroundColor = .clear
        t.tableFooterView = UIView()
        t.register(MvTableViewCell.self, forCellReuseIdentifier: MvTableViewCellIdentifier)
        
        return t
    }()
    
}

extension MvDetailViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlist?.mv_items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MvTableViewCellIdentifier, for: indexPath) as! MvTableViewCell
        cell.mv = self.playlist?.mv_items[indexPath.row]
        return cell
    }
}

extension MvDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(indexPath)
    }
}

