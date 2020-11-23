//
//  SingerTableViewCell.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit

class SingerTableViewCell: UITableViewCell {
    
    // MARK:- LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coverImage)
        coverImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        coverImage.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        
        contentView.addSubview(singerName)
        singerName.autoAlignAxis(toSuperviewAxis: .horizontal)
        singerName.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Func
    
    // MARK:- Other
    
    // MARK:- Setter
    var singer: Singer? {
        didSet {
            singerName.text = singer?.name
        }
    }
    
    
    // MARK:- LazyInit
    lazy var coverImage: UIImageView = {
        let cover = UIImageView()
        cover.layer.cornerRadius = self.height/2
        cover.clipsToBounds = true
        return cover
    }()
    
    lazy var singerName: UILabel = {
        let name = UILabel()
        name.text = "name"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18)
        return name
    }()
}
