//
//  ListViewModel.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import Foundation

class BaseViewModel {
    
    // MARK: UI
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
}

class ListViewModel: BaseViewModel {
    
    // MARK: Properties
    private let client: APIClient
    
    // MARK: - Data Array
    var dataArray: [ItemData] = []
    
    // MARK: - Dependency Injections
    init(client: APIClient) {
        self.client = client
    }
    
    // MARK: - Fetch API Data
    func fetchData() {
        
        //Loader is visible
        self.isLoading = true
        
        // Fetch API Data
        self.client.fetch { [weak self] either in
            
            guard let strongself = self else {return}
            
            switch either {
            case .success(let data):
                strongself.dataArray = []
                strongself.dataArray = data.rows.filter({(($0.title ?? "").count > 0 && ($0.description ?? "").count > 0) || ($0.title ?? "").count > 0 })
            case .error(let error):
                strongself.showError?(error)
            }
            //Hide Loader
            strongself.isLoading = false
            
            //Reload Tableview
            strongself.reloadData?()
        }
    }
}
