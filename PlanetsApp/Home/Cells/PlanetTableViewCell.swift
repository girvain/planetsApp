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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewFilms: UICollectionView!
    @IBOutlet weak var spinnerFilms: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFilms.dataSource = self
        collectionView.register(UINib(nibName: "ResidentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ResidentCollectionViewCell")
        collectionViewFilms.register(UINib(nibName: "FilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilmCollectionViewCell")
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
            toggleUpdatedCollectionView(show: true)
        case .loading:
            toggleUpdatedCollectionView(show: false)
        }
    }
    
    func toggleUpdatedCollectionView(show: Bool) {
        if show {
            spinner.isHidden = true
            spinner.stopAnimating()
            collectionView.isHidden = false
            collectionView.sizeToFit()
            collectionView.reloadData()
            spinnerFilms.isHidden = true
            spinnerFilms.stopAnimating()
            collectionViewFilms.isHidden = false
            collectionViewFilms.sizeToFit()
            collectionViewFilms.reloadData()
        } else {
            spinner.isHidden = false
            spinner.startAnimating()
            collectionView.isHidden = false
            collectionView.sizeToFit()
            collectionView.reloadData()
            spinnerFilms.isHidden = false
            spinnerFilms.startAnimating()
            collectionViewFilms.isHidden = false
            collectionViewFilms.sizeToFit()
            collectionViewFilms.reloadData()
        }
    }
}

extension PlanetTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return viewModel?.getResidentsListCount() ?? 0
        }
        return viewModel?.getFilmsListCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResidentCollectionViewCell", for: indexPath) as! ResidentCollectionViewCell
            if let resident = viewModel?.getResident(indexPath: indexPath.row) {
                cell.configure(data: resident)
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCollectionViewCell", for: indexPath) as! FilmCollectionViewCell
        if let film = viewModel?.getFilm(indexPath: indexPath.row) {
            cell.configure(data: film)
        }
        return cell
        
    }
}
