//
//  PlanetTableViewCellViewModel.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

class PlanetTableViewCellViewModel: ViewModelProtocol {
    
    var model: Result? = nil
    
    func setDataModel(model: Result) {
        self.model = model
        update?(.updated)
    }
    
    func getFilmsListCount() -> Int {
        return model?.films.count ?? 0
    }
    
    func getFilm(indexPath: Int) -> String? {
        return model?.films[indexPath]
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
