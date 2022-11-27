//
//  GroupsViewController.swift
//  ITS
//
//  Created by Natalia on 26.11.2022.
//

import UIKit
import PinLayout

class GroupsViewController: UIViewController {
    
    // MARK: - Create objects
    
    private let addGroupButton: UIButton = UIButton()

    private let collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GroupCell.self, forCellWithReuseIdentifier: "GroupCell")
        
        collectionView.contentInset = UIEdgeInsets(top: 7,
                                                   left: .zero,
                                                   bottom: .zero,
                                                   right: .zero)

        return collectionView
    }()
    
    private var models: [GroupCellModel] = []
    
    // MARK: - setup
    
    private func setupCollectionView() {

        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func setupAddGroupButton() {

        addGroupButton.setImage(UIImage(systemName: Constants.AddGroupButton.iconName), for: .normal)
        addGroupButton.imageView?.tintColor = .white
        addGroupButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        addGroupButton.backgroundColor = Constants.AddGroupButton.backgroundColor
        addGroupButton.layer.cornerRadius = Constants.AddGroupButton.cornerRadius
        addGroupButton.addTarget(self, action: #selector(didTapAddGroupButton), for: .touchUpInside)
        addGroupButton.clipsToBounds = true
        
        view.addSubview(addGroupButton)
    }

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    
        setupCollectionView()
        loadGroups()
        setupAddGroupButton()
        
        tabBarController?.view.addSubview(addGroupButton)

    }
    
    // MARK: - WiewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
        
    }
    
    // MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
        
    }
    
    // MARK: - Load places
    
    // Загружаем данные из БД
    private func loadGroups() {
        
        let groupModel = GroupCellDataModel()
        models = groupModel.loadGroups()
    }
    
    // MARK: - set up navigation bar
    
    private func setupNavBar() {
        
//        navigationItem.title = "Devices"
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark"),
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(didTapQuestionButton))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didTapProfileButton))
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    // MARK: - Layout
    
    private func layout() {
        
        addGroupButton.pin
            .bottom()
            .marginBottom(Constants.AddGroupButton.marginBottom)
            .height(Constants.AddGroupButton.height)
            .horizontally((view.frame.width - Constants.AddGroupButton.height) / 2)
        
        collectionView.pin
            .top(view.safeAreaInsets.top + 7)
            .horizontally()
            .bottom(addGroupButton.frame.height + Constants.AddGroupButton.marginBottom * 2)
    }
    
    // MARK: - add place cell
    
    private func addGroupCell(with name: String) {
        
        let model = GroupCellModel(name: name)
        self.models.append(model)
        
        self.collectionView.insertItems(at: [IndexPath(row: self.models.count - 1, section: 0)])
    }
    
    // MARK: - Question button action
    
    @objc
    private func didTapQuestionButton() {
        
        let alertController: UIAlertController = UIAlertController(title: "Инструкция",
                                                 message: "Для добавления устройства, нажмите кнопку + внизу экрана. Далее укажите название устройства, его сеть и данные, которые оно будет считывать",
                                                 preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "Ок", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Profile button action
    
    @objc
    private func didTapProfileButton() {
        
    }
    
    // MARK: - Add button action
    
    @objc
    private func didTapAddGroupButton() {
        
        let alertController  = UIAlertController(title: "Add group", message: "Input group`s name", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text else {
                return
            }
    
            self.addGroupCell(with: text)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GroupsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    // Создание ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as? GroupCell,
            models.count > indexPath.row
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        self.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(GroupsViewController(), animated: true)
//        self.hidesBottomBarWhenPushed = false
//        
//        deviceViewController.title = models[indexPath.row].name
//
//        let navigationController = UINavigationController(rootViewController: deviceViewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        
//        present(navigationController, animated: true)
//    }
}

// MARK: - Cells size

extension GroupsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 30, height: 70)
    }
}

// MARK: - Static values

private extension GroupsViewController {
    struct Constants {
        
        static let customBlue = UIColor(red: 0x27 / 255,
                                        green: 0x4c / 255,
                                        blue: 0x77 / 255,
                                        alpha: 1)
        
        struct AddGroupButton {
            static let iconName: String = "plus"
            static let backgroundColor: UIColor = Constants.customBlue
            static let marginBottom: CGFloat = 7
            static let height: CGFloat = 65
            static let cornerRadius: CGFloat = height / 2
        }
    }
}
