//
//  ViewModelProtocol.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype UpdateType
    associatedtype ErrorType
    var update: ((UpdateType) -> Void)? { get set }
    var error: ((ErrorType) -> Void)? { get set }
}
