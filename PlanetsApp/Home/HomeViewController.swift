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
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PlanetTableViewCell", bundle: nil), forCellReuseIdentifier: "PlanetTableViewCell")
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
        tableView.isHidden = false
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.planetList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell", for: indexPath) as! PlanetTableViewCell
        if let result = viewModel.planetList?.results[indexPath.row] {
            cell.setData(data: result)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
