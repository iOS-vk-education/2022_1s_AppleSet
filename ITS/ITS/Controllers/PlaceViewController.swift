//
//  PlaceViewController.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit

final class PlaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    // MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }
    
    // MARK: - Setup
    
    private func setupNavBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
}
