//
//  ListDesignViewController.swift
//  Excercise
//
//  Created by Umesh on 08/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

class ListDesignViewController: UIViewController {

    //MARK: - UI Designs
    let tableViewList: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .white
        return table
    }()
    
    let container:UIView = {
        let view = UIView()
        return view
    }()
    
    let activityIndicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.gray
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        return indicator
    }()
    
    let loadingLabel:UILabel = {
        let label = UILabel()
        label.text = "Loading.."
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = label.text?.uppercased()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        setupContainer()
    }
    
    private func setupTableView(){
        view.addSubview(self.tableViewList)
        if #available(iOS 11.0, *) {
            self.tableViewList.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.tableViewList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                self.tableViewList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                self.tableViewList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                self.tableViewList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        } else {
            // Fallback on earlier versions
            view.addConstraintsWithFormat("H:|[v0]|", views: self.tableViewList)
            view.addConstraintsWithFormat("V:|[v0]|", views: self.tableViewList)
        }
    }
    
    private func setupContainer() {
        
        view.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.anchorCenterSuperview()
        
        container.addSubview(activityIndicator)
        container.addSubview(loadingLabel)
        
        container.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0))
        container.addConstraintsWithFormat("V:|[v0]", views: activityIndicator)
        
        container.addConstraintsWithFormat("H:|[v0]|", views: loadingLabel)
        container.addConstraintsWithFormat("V:[v0]-4-[v1]|", views: activityIndicator,loadingLabel)
    }
    
    private func setupNavigation(){
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.barTintColor = .white
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        } else {
            // Fallback on earlier versions
        }
        self.view.backgroundColor = .white
    }
    
}
