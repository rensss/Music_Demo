//
//  MvTableViewCell.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit

class MvTableViewCell: UITableViewCell {

    // MARK:- LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coverImage)
        coverImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        coverImage.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        coverImage.autoSetDimensions(to: CGSize(width: 70, height: 70))
        
        contentView.addSubview(title)
        title.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withOffset: -18)
        title.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 15)
        title.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        
        contentView.addSubview(mvDuration)
        mvDuration.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withOffset: 18)
        mvDuration.autoPinEdge(.left, to: .right, of: coverImage, withOffset: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setter
    var mv: Mv? {
        didSet {
            if let url = mv?.img_url, mv?.img_url.count ?? 0 > 0 {
                coverImage.kf.setImage(with: URL(string: url), placeholder: nil, completionHandler:  { (result) in
                    switch result {
                    case .success(let imageResult):
                        self.coverImage.image = imageResult.image
                    case .failure(let error):
                        debugPrint("---- error --- \(String(describing: self.mv)) --- \(error)")
                    }
                })
            }
            
            title.text = mv?.title
            mvDuration.text = Utils.getFormatTime(duration: mv?.duration ?? 0)
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
    
    lazy var title: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: 18)
        return name
    }()
    
    lazy var mvDuration: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 18)
        return l
    }()

}
