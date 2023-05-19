//
//  HomeViewController.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 17/05/2023.
//

import UIKit

/**
 TODO:
 - [ ] Implement the time out on network call get
 */

class HomeViewController: MVVMViewController<HomeViewModel> {
    
    @IBOutlet var loadingView: UIActivityIndicatorView!
    @IBOutlet var errorMessage: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getPlanetsData()
    }
    
    override func updateView(_ type: HomeViewModel.UpdateType) {
        switch type {
        case .loading:
            loadingView.startAnimating()
        case .updated:
            endLoading()
        }
        
    }
    
    override func handle(_ error: HomeViewModel.ErrorType) {
        switch error {
        case .networkError:
            endLoading()
        }
    }
    
    private func endLoading() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
}
