//
//  PlaceViewController.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit
import PinLayout

final class PlaceViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DeviceCell.self, forCellWithReuseIdentifier: "DeviceCell")
       
//        collectionView.contentInset = UIEdgeInsets(top: 8,
//                                                   left: .zero,
//                                                   bottom: .zero,
//                                                   right: .zero)
        
        return collectionView
    }()
    
    private var models: [DeviceCellModel] = []

    private func setup()
    {
        view.backgroundColor = .systemBlue
        
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadDevice()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
            .bottom()
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
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
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
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height:  view.frame.width)
        } else {
            return CGSize(width: view.frame.width, height: view.frame.width)
        }
    }
}

