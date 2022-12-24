//
//  ProfileViewController.swift
//  ITS
//
//  Created by New on 24.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }
    
    private func setupNavBar(){
        let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func didTapBackButton()
    {
        dismiss(animated: true)
    }
}
