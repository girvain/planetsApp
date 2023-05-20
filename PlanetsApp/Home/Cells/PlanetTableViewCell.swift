//
//  PlanetTableViewCell.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import UIKit

class PlanetTableViewCell: MVVMTableViewCell<PlanetTableViewCellViewModel> {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var climate: UILabel!
    @IBOutlet weak var terrain: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ResidentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResidentCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // we have to init and configure the viewModel in the implementation rather than the framework level
        // due to the OOO of UIKit, using the init(coder) and not allowing init with a generic.
        self.viewModel = PlanetTableViewCellViewModel()
        self.bind()
    }
    
    func configure(data: Result) {
        self.viewModel?.setDataModel(model: data)
        
    }
    
    override func updateView(_ type: PlanetTableViewCellViewModel.UpdateType) {
        switch type {
        case .updated:
            name.text = viewModel?.model?.name
            population.text = viewModel?.model?.population
            climate.text = viewModel?.model?.climate
            terrain.text = viewModel?.model?.terrain
        case .loading:
            print("loading")
        }
        
    }
}

extension PlanetTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getFilmsListCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResidentCollectionViewCell", for: indexPath) as! ResidentCollectionViewCell
        if let film = viewModel?.getFilm(indexPath: indexPath.row) {
            cell.configure(data: film)
        }
        return cell
    }
}
