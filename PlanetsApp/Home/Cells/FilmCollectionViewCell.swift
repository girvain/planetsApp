//
//  ResidentCollectionViewCell.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var episode: UILabel!
    @IBOutlet weak var year: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Film) {
        self.title.text = data.title
        self.episode.text = "\(data.episodeID)"
        self.year.text = data.releaseDate
    }

}
