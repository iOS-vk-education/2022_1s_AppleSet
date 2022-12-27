//
//  ProfileViewController.swift
//  ITS
//
//  Created by New on 24.12.2022.
//

import UIKit
import PinLayout
import Firebase

final class ProfileViewController: UIViewController
{
    
   @Published var list = [users]()
    private var avatarImage: UIImageView = UIImageView()
    private let mail: UILabel = UILabel()
    private let username: UILabel = UILabel()
    private let logOutButton: UIButton = UIButton()
    private let ChangePassword: UIButton = UIButton()
    private let UserPhoto: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.image = UIImage(named: "")
        avatarImage.layer.cornerRadius = 75
        avatarImage.contentMode = .scaleToFill
        avatarImage.clipsToBounds = true
        
        username.text = "Username"
        username.font = UIFont(name: "Noteworthy", size: 32)
        username.textColor = .black
        
        mail.text = "Mail"
        mail.font = UIFont(name: "Noteworthy", size: 32)
        mail.textColor = .black
        
        logOutButton.backgroundColor = .customBlue.withAlphaComponent(0.8)
        logOutButton.setTitleColor(.black, for: .normal)
        logOutButton.layer.cornerRadius = Constans.EditButton.cornerRadius
        logOutButton.setTitle("Logout", for: .normal)
        
        ChangePassword.backgroundColor = .customBlue.withAlphaComponent(0.8)
        ChangePassword.setTitleColor(.black, for: .normal)
        ChangePassword.layer.cornerRadius = Constans.EditButton.cornerRadius
        ChangePassword.setTitle("Change password", for: .normal)
        
        UserPhoto.backgroundColor = .white
        UserPhoto.setTitleColor(.customDarkBlue, for: .normal)
        UserPhoto.setTitle("Choose photo", for: .normal)
        
        view.addSubview(mail)
        view.addSubview(avatarImage)
        view.addSubview(username)
        view.addSubview(logOutButton)
        view.addSubview(ChangePassword)
        view.addSubview(UserPhoto)
//
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        UserPhoto.addTarget(self, action: #selector(ChooseUserPhoto), for: .touchUpInside)
        username.text = "Username"
        
        
        view.backgroundColor = .white
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            let user =  Auth.auth().currentUser
            if let user = user {
                mail.text = user.email
            }
            
            let db = Firestore.firestore()
            db.collection("users").getDocuments { QuerySnapshot, error in
                if error == nil {

                    if let QuerySnapshot = QuerySnapshot {

                        DispatchQueue.main.async {
                            self.list = QuerySnapshot.documents.map { d in
                                
                                if ((d["email"] as? String ?? "") == self.mail.text) {
                                    self.username.text = d["username"] as? String ?? ""
                                    self.avatarImage.image = UIImage(named: d["avatarImageName"] as? String ?? "")
                                    return users(id: d["uid"] as? String ?? "", username: d["username"] as? String ?? "", email: d["email"] as? String ?? "", avatarImageName: d["avatarImageName"] as? String ?? "")
                                }
                                
                                return users(id: "", username: "", email: "", avatarImageName: "")
                            }
                        }
                    }
                    else {
                        print ("error9")
                    }
                }
            }
        }
    
    
        view.addSubview(mail)
        view.addSubview(avatarImage)
        view.addSubview(username)
        view.addSubview(logOutButton)
        view.addSubview(ChangePassword)
        view.addSubview(UserPhoto)
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
        title = "Profile"
    }
    
   
    
        override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       


//        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        layout()
    }
    
    private func layout(){
        avatarImage.pin
            .top()
            .marginTop(view.safeAreaInsets.top)
            .hCenter()
            .size(CGSize(width: 150, height: 150))
        
        UserPhoto.pin
            .below(of: avatarImage)
            .height(Constans.EditButton.height)
            .horizontally(Constans.EditButton.marginHorizontal)

        username.pin
            .below(of:  UserPhoto)
            .marginTop(Constans.NameTitle.marginTop)
            .horizontally(Constans.NameTitle.marginHorizontal)
            .sizeToFit(.width)
            .hCenter()
        
        mail.pin
            .below(of: username)
            .marginTop(Constans.NameTitle.marginTop)
            .horizontally(Constans.NameTitle.marginHorizontal)
            .sizeToFit(.width)
            .hCenter()
        
        ChangePassword.pin
            .bottom()
            .marginBottom(view.safeAreaInsets.bottom + Constans.EditButton.marginBottom + 110)
            .height(Constans.EditButton.height)
            .horizontally(Constans.EditButton.marginHorizontal)
        
        logOutButton.pin
            .bottom()
            .marginBottom(view.safeAreaInsets.bottom + Constans.EditButton.marginBottom + 60)
            .height(Constans.EditButton.height)
            .horizontally(Constans.EditButton.marginHorizontal)
            
        
    }
        @objc func didTapBackButton()
    {
        dismiss(animated: true)
    }
    
    @objc func logOut()
    {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            logOutButton.removeFromSuperview()
            
            let toMainController = RegistrationController()
            let navigationController = UINavigationController(rootViewController: toMainController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }
        catch {
            print("An error occurred")
        }
    }
    
    @objc func ChooseUserPhoto()
    {
        
    }
    
//   private extension ProfileViewController {
    struct Constans {

        struct AvatarImage {
            static let marginTop: CGFloat = 10
            static let size: CGSize = CGSize(width: 150, height: 150)
        }
        
        struct NameTitle {
            static let marginTop: CGFloat = 16
            static let marginHorizontal: CGFloat = 50
        }
        
        
        struct EditButton {
            static let cornerRadius: CGFloat = 8
            static let height: CGFloat = 42
            static let marginHorizontal: CGFloat = 52
            static let marginBottom: CGFloat = 10
        }
    }
}
