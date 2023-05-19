//
//  HomeViewController.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 17/05/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var planetList: PlanetList? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network().callAPI(url: "https://swapi.dev/api/planets", model: PlanetList.self) { res -> Void in
            do {
                self.planetList = try res.get()
            } catch {
                print("error")
            }
        }
    }
}
