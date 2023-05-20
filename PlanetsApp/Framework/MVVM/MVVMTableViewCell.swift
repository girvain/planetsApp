//
//  MVVMViewController.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//
import Foundation
import UIKit

class MVVMTableViewCell<ViewModel: ViewModelProtocol>: UITableViewCell {
    
    var viewModel: ViewModel? = nil 
    
    // MARK: - Initialisation
    
    // not used!
    init(viewModel: ViewModel) {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    // this is the init used for creating cells, so we must declare the viewModel and call bind
    // on the implementation manually as we can't pass in the VM like in the above init.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Binding
    
    func bind() {
        self.viewModel?.update = { [weak self] type in
            Thread.runOnMain {
                self?.updateView(type)
            }
        }
        self.viewModel?.error = { [weak self] error in
            Thread.runOnMain {
                self?.handle(error)
            }
        }
    }
    
    // MARK: - View Update
    
    func updateView(_ type: ViewModel.UpdateType) { assertionFailure("updates are not being handled") }
    
    // MARK: - Error Handling
    
    func handle(_ error: ViewModel.ErrorType) { assertionFailure("errors are not being handled") }
}
