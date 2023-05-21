//
//  PlanetTableViewCellViewModel.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

class PlanetTableViewCellViewModel: ViewModelProtocol {
    
    var model: Result? = nil
    // set this as mutable so it can be changed out if needed for unit testing
    var network = Network()
    
    func setDataModel(model: Result) {
        // update now that we have a data model set
        self.model = model
        // now set the state to loading
        update?(.updated)
        // now check if we have urls to fetch the data from, and if we have done it already
        if model.filmsData == nil {
            update?(.loading)
            self.model?.filmsData = []
            self.getFilmData()
        }
        if model.residentsData == nil {
            update?(.loading)
            self.model?.residentsData = []
            self.getResidentData()
        }
    }
    
    func getFilmsListCount() -> Int {
        return model?.filmsData?.count ?? 0
    }
    
    func getResidentsListCount() -> Int {
        return model?.residentsData?.count ?? 0
    }
    
    func getFilm(indexPath: Int) -> Film? {
        return model?.filmsData?[indexPath]
    }
    
    func getResident(indexPath: Int) -> Resident? {
        return model?.residentsData?[indexPath]
    }

    
    // MARK: - Network
    
    func getFilmData() {
        let group = DispatchGroup()
        model?.films.forEach { url in
            group.enter()
            network.get(url: url, model: Film.self) { [weak self] res in
                do {
                    try self?.model?.filmsData?.append(res.get())
                } catch {
                    print("failure")
                }
                print(res)
                group.leave()
            }
        }

        group.notify(queue: .main) {
            // this is called when every `enter` call is matched up with a `leave` Call
            self.update?(.updated)
        }
    }
    
    func getResidentData() {
        let group = DispatchGroup()
        model?.residents.forEach { url in
            group.enter()
            network.get(url: url, model: Resident.self) { [weak self] res in
                do {
                    try self?.model?.residentsData?.append(res.get())
                } catch {
                    print("failure")
                }
                print(res)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.update?(.updated)
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
