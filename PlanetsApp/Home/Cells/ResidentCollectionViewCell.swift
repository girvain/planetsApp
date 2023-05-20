//
//  ResidentCollectionViewCell.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import UIKit

class ResidentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: String) {
        self.title.text = data
    }

}
