//
//  DetailViewController.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    // MARK: - Response Object
    var setData: ItemData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews(){
        guard let data = setData else {return}
        self.detailTitle.text = data.title
        self.title = data.title ?? "Detail"
        self.detailDescription.text = data.description
        self.detailImageView.loadImageUsingCacheWithURLString(data.imageHref ?? "", placeHolder: UIImage(named: "placeholder")) { _ in }
    }

}
