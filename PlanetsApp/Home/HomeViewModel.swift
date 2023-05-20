//
//  HomeViewModel.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

class HomeViewModel: ViewModelProtocol {
    
    var planetList: PlanetList? = nil
    
    func getPlanetListSize() -> Int {
        return planetList?.results.count ?? 0
    }
    
    func getPlanet(indexPath: Int) -> Result? {
        return planetList?.results[indexPath]
    }
    
    // MARK: - Network
    func getPlanetsData() {
        // set state to loading
        self.update?(.loading)
        // get the data using networking service
        Network().get(url: "https://swapi.dev/api/planets", model: PlanetList.self) { [weak self] res -> Void in
            do {
                self?.planetList = try res.get()
                self?.update?(.updated)
            } catch {
                // probably not a network error at this point but i'll hopefully come back to this
                self?.error?(.networkError)
            }
        }
        
    }
    
    // MARK: - MVVM binding stuff
    enum UpdateType {
        case loading
        case updated
    }
    enum ErrorType {
        case networkError
    }
    
    // this is just here to be assigned it's update code block from the view (controller)
    var update: ((UpdateType) -> Void)?
    var error: ((ErrorType) -> Void)?
}
