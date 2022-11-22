//
//  PlaceViewController.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit
import PinLayout

final class PlaceViewController: UIViewController {
    
    private let addDeviceButton: UIButton = UIButton()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DeviceCell.self, forCellWithReuseIdentifier: "DeviceCell")
       
        collectionView.contentInset = UIEdgeInsets(top: 7,
                                                   left: .zero,
                                                   bottom: .zero,
                                                   right: .zero)
        
        return collectionView
    }()
    
    private var models: [DeviceCellModel] = []

    private func setup()
    {
        view.backgroundColor = .white
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func setupAddDeviceButton() {

        addDeviceButton.setImage(UIImage(systemName: Constants.AddDeviceButton.iconName), for: .normal)
        addDeviceButton.imageView?.tintColor = .white
        addDeviceButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        addDeviceButton.backgroundColor = Constants.AddDeviceButton.backgroundColor
        addDeviceButton.layer.cornerRadius = Constants.AddDeviceButton.cornerRadius
        addDeviceButton.addTarget(self, action: #selector(didTapAddPlaceButton), for: .touchUpInside)
        addDeviceButton.clipsToBounds = true
        
        view.addSubview(addDeviceButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddDeviceButton()
        setup()
        loadDevice()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addDeviceButton.pin
            .bottom()
            .marginBottom(view.safeAreaInsets.bottom + Constants.AddDeviceButton.marginBottom)
            .height(Constants.AddDeviceButton.height)
            .horizontally((view.frame.width - Constants.AddDeviceButton.height) / 2)
        
        collectionView.pin
            .top(view.safeAreaInsets.top + 7)
            .horizontally()
            .bottom(view.safeAreaInsets.bottom + addDeviceButton.frame.height + Constants.AddDeviceButton.marginBottom * 2)
        
    }
    
    private func loadDevice() {
        let deviceModel = DeviceCellDataModel()
        models = deviceModel.loadPlaces()
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
    
    // MARK: - add place cell
    
    private func addDeviceCell(with name: String) {
        
        let model = DeviceCellModel(name: name)
        self.models.append(model)
    
        self.collectionView.insertItems(at: [IndexPath(row: self.models.count - 1, section: 0)])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }

    @objc
    private func didTapAddPlaceButton() {
        
        let alertController  = UIAlertController(title: "Добавить устройство", message: "Введите название устройства", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text else {
                return
            }
    
            self.addDeviceCell(with: text)
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
}

extension PlaceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceCell",
                                                          for: indexPath) as? DeviceCell,
                models.count > indexPath.row
            else {
                return UICollectionViewCell()
        }
        
        cell.configure(with: models[indexPath.row])
        return cell
    }
}

extension PlaceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: 100)
    }
}

private extension PlaceViewController {
    struct Constants {
        
        static let customBlue = UIColor(red: 0x27 / 255,
                                        green: 0x4c / 255,
                                        blue: 0x77 / 255,
                                        alpha: 1)
        
        struct AddDeviceButton {
            static let iconName: String = "plus"
            static let backgroundColor: UIColor = Constants.customBlue
            static let marginBottom: CGFloat = 7
            static let height: CGFloat = 65
            static let cornerRadius: CGFloat = height / 2
        }
    }
}

