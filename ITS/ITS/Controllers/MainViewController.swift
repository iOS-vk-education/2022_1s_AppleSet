//
//  ViewController.swift
//  ITS
//
//  Created by Всеволод on 02.11.2022.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
    
    // MARK: - Create objects
    
    private let addPlaceButton: UIButton = UIButton()

    private let collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: "PlaceCell")
        
        collectionView.contentInset = UIEdgeInsets(top: 7,
                                                   left: .zero,
                                                   bottom: .zero,
                                                   right: .zero)

        return collectionView
    }()
    
    private var models: [PlaceCellModel] = []
    
    // MARK: - setup
    
    private func setupCollectionView() {

        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func setupAddPlaceButton() {

        addPlaceButton.setImage(UIImage(systemName: Constants.AddPlaceButton.iconName), for: .normal)
        addPlaceButton.imageView?.tintColor = .white
        // Размер картинки!!!
        addPlaceButton.backgroundColor = Constants.AddPlaceButton.backgroundColor
        addPlaceButton.layer.cornerRadius = Constants.AddPlaceButton.cornerRadius
        addPlaceButton.addTarget(self, action: #selector(didTapAddPlaceButton), for: .touchUpInside)
        addPlaceButton.clipsToBounds = true
        
        view.addSubview(addPlaceButton)
    }

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    
        setupCollectionView()
        loadPlaces()
        setupAddPlaceButton()
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
    private func loadPlaces() {
        
        let placeModel = PlaceCellDataModel()
        models = placeModel.loadPlaces()
    }
    
    // MARK: - set up navigation bar
    
    private func setupNavBar() {
        
        navigationItem.title = "Мои места"
        
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
        
        addPlaceButton.pin
            .bottom()
            .marginBottom(view.safeAreaInsets.bottom + Constants.AddPlaceButton.marginBottom)
            .height(Constants.AddPlaceButton.height)
            .horizontally((view.frame.width - Constants.AddPlaceButton.height) / 2)
        
        collectionView.pin
            .top(view.safeAreaInsets.top + 7)
            .horizontally()
            .bottom(view.safeAreaInsets.bottom + addPlaceButton.frame.height + Constants.AddPlaceButton.marginBottom * 2)
    }
    
    // MARK: - add place cell
    
    private func addPlaceCell(with name: String) {
        
        let model = PlaceCellModel(name: name)
        self.models.append(model)
        
        // Исправить ошибку!!!
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
    private func didTapAddPlaceButton() {
        
        let alertController  = UIAlertController(title: "Добавить место", message: "Введите название места", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text else {
                return
            }
    
            self.addPlaceCell(with: text)
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    // Создание ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as? PlaceCell,
            models.count > indexPath.row
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeViewController = PlaceViewController()
        placeViewController.title = models[indexPath.row].name
        
        let navigationController = UINavigationController(rootViewController: placeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
}

// MARK: - Cells size

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 30, height: 70)
    }
}

// MARK: - Static values

private extension MainViewController {
    struct Constants {
        
        static let customBlue = UIColor(red: 0x27 / 255,
                                        green: 0x4c / 255,
                                        blue: 0x77 / 255,
                                        alpha: 1)
        
        struct AddPlaceButton {
            static let iconName: String = "plus.circle"
            static let backgroundColor: UIColor = Constants.customBlue
            static let marginBottom: CGFloat = 17
            static let height: CGFloat = 50
            static let cornerRadius: CGFloat = height / 2
        }
    }
}
