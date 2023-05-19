//
//  PlanetTableViewCell.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var climate: UILabel!
    @IBOutlet weak var terrain: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: Result) {
        name.text = data.name
        population.text = data.population
        climate.text = data.climate
        terrain.text = data.terrain
    }
}
