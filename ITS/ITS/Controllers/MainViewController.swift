//
//  ViewController.swift
//  ITS
//
//  Created by Всеволод on 02.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0xe7 / 255,
                                       green: 0xec / 255,
                                       blue: 0xef / 255,
                                       alpha: 1)
    }
    
    // MARK: - WiewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
        
    }
    
    // MARK: - set up navigation bar
    
    private func setupNavBar() {
        
        navigationItem.title = "Мои устройства"
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTapQuestionButton))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc
    private func didTapQuestionButton() {
        let alertController  = UIAlertController(title: "Инструкция",
                                                 message: "Для добавления устройства, нажмите кнопку + внизу экрана. Далее укажите название устройства, его сеть и данные, которые оно будет считывать",
                                                 preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default)
        
        alertController.addAction(okAction)
        
        
        present(alertController, animated: true)
    }
}
