//
//  HomeViewModel.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation
import Network

class HomeViewModel: ViewModelProtocol {
    
    var planetList: PlanetList? = nil
    let monitor = NWPathMonitor()
    
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
                let planetListLocal = try res.get()
                self?.planetList = planetListLocal
                self?.update?(.updated)
                try FileCacheService().save(model: planetListLocal, toFilename: "planetList")
            } catch {
                // probably not a network error at this point but i'll hopefully come back to this
                self?.error?(.networkError)
            }
        }
    }
    
    func getPlanetsDataOffline() {
        do {
            self.update?(.loading)
            self.planetList = try FileCacheService().loadJSON(model: PlanetList.self, withFilename: "planetList")
            self.update?(.updated)
        } catch {
            // TODO: add proper error state for this
            self.error?(.networkError)
        }
    }
    
    func getPlanets() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                print("Connected")
                self?.getPlanetsData()
           } else {
               print("Disconnected")
               self?.getPlanetsDataOffline()
           }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.cancel()
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
