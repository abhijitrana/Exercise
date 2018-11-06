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
        self.client.fetch { either in
            switch either {
            case .success(let data):
                self.dataArray = []
                self.dataArray = data.rows
            case .error(let error):
                self.showError?(error)
            }
            //Hide Loader
            self.isLoading = false
            
            //Reload Tableview
            self.reloadData?()
        }
    }
}
