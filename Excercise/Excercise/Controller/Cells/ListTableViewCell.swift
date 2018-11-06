//
//  ListTableViewCell.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    var setData:ItemData? = nil {
        didSet {
            guard let data =  setData else {return}
            self.cellTitle.text = data.title
            self.cellDescription.text = data.description
            
            self.cellImage.loadImageUsingCacheWithURLString(data.imageHref ?? "", placeHolder: UIImage(named: "placeholder")) { _ in }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
