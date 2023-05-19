//
//  MVVMViewController.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//
import Foundation
import UIKit

class MVVMViewController<ViewModel: ViewModelProtocol>: UIViewController {
    
    var viewModel: ViewModel
    
    // MARK: - Initialisation
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    // MARK: - Binding
    
    func bind() {
        self.viewModel.update = { [weak self] type in
            Thread.runOnMain {
                self?.updateView(type)
            }
        }
        self.viewModel.error = { [weak self] error in
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
