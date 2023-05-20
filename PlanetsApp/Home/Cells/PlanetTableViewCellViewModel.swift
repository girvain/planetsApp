//
//  PlanetTableViewCellViewModel.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

class PlanetTableViewCellViewModel: ViewModelProtocol {
    
    var model: Result? = nil
    var films = [Film]()
    var hasFilmData = false
    var residents = [Resident]()
    var hasResidentsData = false
    
    func setDataModel(model: Result) {
        self.model = model
        // update now that we have a data model set
        update?(.updated)
        // now set the state to loading
        if !hasFilmData {
            update?(.loading)
            self.getFilmData()
        }
        if !hasResidentsData {
            update?(.loading)
            self.getResidentData()
        }
    }
    
    func getFilmsListCount() -> Int {
        return films.count
    }
    
    func getResidentsListCount() -> Int {
        return residents.count
    }
    
    func getFilm(indexPath: Int) -> Film? {
        if films.isEmpty {
            return nil
        }
        return films[indexPath]
    }
    
    func getResident(indexPath: Int) -> Resident? {
        if residents.isEmpty {
            return nil
        }
        return residents[indexPath]
    }

    
    // MARK: - Network
    
    func getFilmData() {
        let group = DispatchGroup()
        model?.films.forEach { url in
            group.enter()
            Network().get(url: url, model: Film.self) { [weak self] res in
                do {
                    try self?.films.append(res.get())
                } catch {
                    print("failure")
                }
                print(res)
                group.leave()
            }
        }

        group.notify(queue: .main) {
            // this is called when every `enter` call is matched up with a `leave` Call
            print("it worked")
            self.hasFilmData = true
            self.update?(.updated)
        }
    }
    
    func getResidentData() {
        let group = DispatchGroup()
        model?.residents.forEach { url in
            group.enter()
            Network().get(url: url, model: Resident.self) { [weak self] res in
                do {
                    try self?.residents.append(res.get())
                } catch {
                    print("failure")
                }
                print(res)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.hasResidentsData = true
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
