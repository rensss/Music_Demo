//
//  SingerDetailTableViewCell.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit

class SingerDetailTableViewCell: UITableViewCell {

    // MARK:- LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coverImage)
        coverImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        coverImage.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        coverImage.autoSetDimensions(to: CGSize(width: 60, height: 60))
        
        contentView.addSubview(playName)
        playName.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withOffset: -18)
        playName.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 15)
        playName.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        
        contentView.addSubview(playCount)
        playCount.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withOffset: 18)
        playCount.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setter
    var detail: Playlist? {
        didSet {
            if let url = detail?.playlist_img_url, detail?.playlist_img_url.count ?? 0 > 0 {
                coverImage.kf.setImage(with: URL(string: url), placeholder: nil, completionHandler:  { (result) in
                    switch result {
                    case .success(let imageResult):
                        self.coverImage.image = imageResult.image
                    case .failure(let error):
                        debugPrint("---- error --- \(String(describing: self.detail)) --- \(error)")
                    }
                })
            }

            playName.text = detail?.playlist_name
            playCount.text = "\(detail?.mv_total_count ?? 0)"
        }
    }
    
    // MARK:- LazyInit
    lazy var coverImage: UIImageView = {
        let cover = UIImageView()
        cover.layer.cornerRadius = 5
        cover.clipsToBounds = true
        cover.contentMode = .scaleAspectFill
        cover.backgroundColor = UIColor.withRandom()
        return cover
    }()
    
    lazy var playName: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: 18)
        return name
    }()
    
    lazy var playCount: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 18)
        return l
    }()
    
}
