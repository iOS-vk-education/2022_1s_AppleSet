//
//  ProfileViewController.swift
//  ITS
//
//  Created by New on 24.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController
{
    
    private let label: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = "Profile"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let UserName: UILabel = {
        let username = UILabel()
//        label.backgroundColor = .white
        username.textAlignment = .center
        username.text = " "
        username.font = .systemFont(ofSize: 24, weight: .semibold)
        return username
    }()
    
    private let LogOutbutton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customBlue
        button.setTitleColor(.black, for: .normal)
        button.setTitle("logout", for: .normal)
        return button
    }()
    
    private let ChengePassword: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customBlue
        button.setTitleColor(.black, for: .normal)
        button.setTitle("ChengePassword", for: .normal)
        return button
    }()
    
    private let UserImage: UIImage = {
       let image = UIImage(named: <#T##String#>)
    }()
    
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
