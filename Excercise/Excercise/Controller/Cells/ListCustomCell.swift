//
//  ListCustomCell.swift
//  Excercise
//
//  Created by Umesh on 08/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

class ListCustomCell:UITableViewCell {
    
    
    //MARK: - UI Design
    let cellContainer:UIView = {
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellContainer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupCellContainer() {
        contentView.addSubview(cellContainer)
        
        contentView.addConstraintsWithFormat("H:|[v0]|", views: cellContainer)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: cellContainer)
        
        setupViews()
    }
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22.5
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 0.6
        return imageView
    }()
    
    let cellTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = " "
        label.backgroundColor = .white
        return label
    }()
    
    let cellDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.text = "   "
        label.backgroundColor = .white
        return label
    }()
    
    var setData:ItemData? = nil {
        didSet {
            guard let data =  setData else {return}
            self.cellTitle.text = data.title
            
            if let desc = data.description {
                self.cellDescription.numberOfLines = 0
                self.cellDescription.text = desc
            }else {
                self.cellDescription.numberOfLines = 1
                self.cellDescription.text = " "
            }
            
            self.cellImage.loadImageUsingCacheWithURLString(data.imageHref ?? "", placeHolder: UIImage(named: "placeholder")) { _ in }
        }
    }
    
    private func setupViews() {
        
        cellContainer.addSubview(cellImage)
        cellContainer.addSubview(cellTitle)
        cellContainer.addSubview(cellDescription)
        
        //Cell Image
        cellContainer.addConstraintsWithFormat("H:|-16-[v0(45)]", views: cellImage)
        cellContainer.addConstraintsWithFormat("V:[v0(45)]", views: cellImage)
        cellImage.anchorCenterYToSuperview()
        
        //Cell Label
        cellContainer.addConstraintsWithFormat("H:[v0]-16-[v1]", views: cellImage, cellTitle)
        cellContainer.addConstraintsWithFormat("V:|-8-[v0]", views: cellTitle)
        
        //Cell Date Label
        cellContainer.addConstraintsWithFormat("H:[v0]-16-|", views: cellTitle)
        cellContainer.addConstraintsWithFormat("V:|-8-[v0]-4-[v1]-8-|", views: cellTitle,cellDescription)
        
        //Cell Text
        cellContainer.addConstraintsWithFormat("H:[v0]-16-[v1]-16-|", views: cellImage, cellDescription)
        cellContainer.addConstraintsWithFormat("V:[v0]-4-[v1]-8-|", views: cellTitle, cellDescription)
    }
}
