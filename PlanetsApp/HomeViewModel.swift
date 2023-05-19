//
//  HomeViewModel.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

class HomeViewModel: ViewModelProtocol {
    
    var planetList: PlanetList? = nil
    
    func getPlanetsData() {
        // set state to loading
        self.update?(.loading)
        // get the data using networking service
        Network().get(url: "https://swapi.dev/api/planets", model: PlanetList.self) { res -> Void in
            do {
                self.planetList = try res.get()
                self.update?(.updated)
            } catch {
                print("error")
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
