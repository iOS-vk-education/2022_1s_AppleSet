//
//  ProfileViewController.swift
//  ITS
//
//  Created by New on 24.12.2022.
//

import UIKit

final class ProfileViewController: UIViewController
{
    private let avatar: UIImageView = UIImageView()
//    private let label: UILabel = UILabel()
//    private  let username: UILabel = UILabel()
//    private  let logOutButton: UIButton = UIButton()
//    private  let ChangePassword: UIButton = UIButton()
//
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
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("logout", for: .normal)
        return button
    }()

    private let ChangePassword: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("ChangePassword", for: .normal)
        return button
    }()

//    private let UserImage: UIImageView = {
//       let image = UIImageView()
//        image.image = UIImage(named: "avatar")
//        return image
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar.image = UIImage(named: "avatar")
        
        
        view.addSubview(label)
            view.addSubview(avatar)
        view.addSubview(UserName)
        view.addSubview(LogOutbutton)
        view.addSubview(ChangePassword)
        
        
//        label.text = "Profile"
//        username.text = "Username"
        
        
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
    
//    private func layout(){
//        avatar.pin
//            .top()
//            .size(Constans.avatar.size)
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()


        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
//        UserImage.frame = CGRect(x: 20, y: label.frame.origin.y+label.frame.size.height+10,
//                                 width: view.frame.size.width-40, height: 50)
        UserName.frame = CGRect(x: 20, y:  label.frame.origin.y+label.frame.size.height+100,
                                width: view.frame.size.width-40, height: 50)
        LogOutbutton.frame = CGRect(x: 20, y:  UserName.frame.origin.y+UserName.frame.size.height+10,
                                    width: view.frame.size.width-40, height: 50)
        ChangePassword.frame = CGRect(x: 20, y:  LogOutbutton.frame.origin.y+LogOutbutton.frame.size.height+10,
                                      width: view.frame.size.width-40, height: 50)
    }
    
    @objc func didTapBackButton()
    {
        dismiss(animated: true)
    }
}
