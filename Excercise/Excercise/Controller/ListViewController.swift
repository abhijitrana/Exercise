//
//  ListViewController.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewList: UITableView!
    
    //TODO:- Refresher
    let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.gray,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)]
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing, Please Wait...", attributes: attributes)
        refreshControl.tintColor = .gray
        return refreshControl
    }()
    
    // MARK: - Inject ViewModel
    let viewModel = ListViewModel(client: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        setupObservers()
        setupTableView()
    }
    
    private func setupObservers(){
        // View-Model loader
        self.viewModel.showLoading = { [weak self] in
            
            guard let strongself = self else {return}
            
            DispatchQueue.main.async {
                if strongself.viewModel.isLoading {
                    strongself.activityIndicator.startAnimating()
                    strongself.tableViewList.alpha = 0.0
                } else {
                    strongself.activityIndicator.stopAnimating()
                    strongself.tableViewList.alpha = 1.0
                }
            }
            
        }
        
        // View-Model Error Case
        self.viewModel.showError = { [weak self] error in
            guard let strongself = self else {return}
            DispatchQueue.main.async {
                strongself.showAlert(error.localizedDescription)
            }
        }
        
        // View-Model Reload Table view
        self.viewModel.reloadData = { [weak self] in
            guard let strongself = self else {return}
            DispatchQueue.main.async {
                strongself.tableViewList.reloadData()
            }
        }
        
        // View-Model Fetch API Data
        self.viewModel.fetchData()
    }
    
    // MARK: - Setup tableView Delegates
    private func setupTableView() {
        
        //Table View Delegates and Data Source
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        
        //Table View Height Increased Automatic
        self.tableViewList.estimatedRowHeight = 200
        self.tableViewList.rowHeight = UITableViewAutomaticDimension
        
        //Table View with refresh controlller
        self.tableViewList.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    //MARK: - Handle Refresh
    @objc func handleRefresh() {
        if (Connectivity.isConnectedToInternet()){
            // View-Model Fetch API Data
            self.viewModel.fetchData()
        }else {
            showAlert("Internet not connected")
        }
        
        self.refreshControl.endRefreshing()
    }
    
    private func showAlert(_ message:String) {
        let alertController = UIAlertController (title: "Oops", message: message, preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
        })
        
        alertController.addAction(firstAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.setData = self.viewModel.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataArray.count
    }
}

// MARK: - UITableViewDelegates
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier :"DetailViewController") as! DetailViewController
//        viewController.setData = self.viewModel.dataArray[indexPath.row]
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
