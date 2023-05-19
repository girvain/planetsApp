//
//  HomeViewController.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 17/05/2023.
//

import UIKit

class HomeViewController: MVVMViewController<HomeViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getPlanetsData()
    }
    
    override func updateView(_ type: HomeViewModel.UpdateType) {
        switch type {
        case .loading:
            print("loading")
        case .updated:
            print("updated")
        }
        
    }
}
