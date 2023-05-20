//
//  FilmsCollectionViewCell.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 20/05/2023.
//

import UIKit

class FilmsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Resident) {
        name.text = data.name
    }

}
