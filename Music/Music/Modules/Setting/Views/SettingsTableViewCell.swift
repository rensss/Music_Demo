//
//  SettingsTableViewCell.swift
//  Music
//
//  Created by Rzk on 2020/11/25.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK:- LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        title.autoAlignAxis(toSuperviewAxis: .horizontal)
        title.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- LazyInit
    var title: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 18)
        return l
    }()
    
}
