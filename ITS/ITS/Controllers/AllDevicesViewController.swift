//
//  ViewController.swift
//  ITS
//
//  Created by Всеволод on 02.11.2022.
//

//self.models.remove(at: indexPath.row)
//collectionView.deleteItems(at: [indexPath])

import UIKit
import PinLayout

class AllDevicesViewController: UIViewController {
    
    // MARK: - Create objects
    
    private let collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DeviceCell.self, forCellWithReuseIdentifier: "DeviceCell")
        
        collectionView.contentInset = UIEdgeInsets(top: 7,
                                                   left: .zero,
                                                   bottom: .zero,
                                                   right: .zero)
        
        return collectionView
        
    }()
    
    var models: [DeviceCellModel] = []
    let databaseManager = DatabaseManager.shared
    
    // MARK: - setup
    
    private func setupCollectionView() {
        
        // background of main controller
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation bar
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupCollectionView()
        loadDevices()
        
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
    
    // MARK: - set up navigation bar
    
    private func setupNavBar() {
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark"),
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(didTapQuestionButton))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .customGrey
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didTapProfileButton))
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .customGrey
        
    }
    
    // MARK: - Layout
    
    private func layout() {
        
        collectionView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
            .bottom(view.safeAreaInsets.bottom)
        
    }
    
    // MARK: - Load places
    
    // Загружаем данные из БД
    private func loadDevices() {
        
        databaseManager.loadDevices { result in
            switch result {
            case .success(let devices):
                self.models = devices
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - add device cell
    
    func addDeviceCell(with name: String) {
        
        databaseManager.addDevice(device: CreateDeviceData(name: name)) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
//        databaseManager.addDevice(name: name)
//
//        loadDevices()
        
//        self.collectionView.reloadData()
//        self.collectionView.performBatchUpdates({ [weak self] in
//          let visibleItems = self?.collectionView.indexPathsForVisibleItems ?? []
//          self?.collectionView.reloadItems(at: visibleItems)
//        }, completion: { (_) in
//        })
        
//        view = nil
//        setupCollectionView()
//        loadDevices()
        
//        let parent = self.view.superview
//        self.view.removeFromSuperview()
//        self.view = nil
        // unloads the entire view
//        parent?.addSubview(self.view)
        // reloads the view
        
//        let model = DeviceCellModel(name: name)
        
//        self.models.append(model)
        
//        print(self.models)
        
//        self.collectionView.insertItems(at: [IndexPath(row: models.count - 1, section: 0)])
    }
    
    func delDeviceCell(name: String) {
        
        databaseManager.delDevice(device: CreateDeviceData(name: name)) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
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
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension AllDevicesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return models.count
        
    }
    
    // Создание ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceCell", for: indexPath) as? DeviceCell,
            models.count > indexPath.row
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
    // Переход в контроллер ячейки
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let deviceViewController = DeviceViewController()
        deviceViewController.title = models[indexPath.row].name

        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(deviceViewController, animated: true)
        self.hidesBottomBarWhenPushed = false

    }
    
}

// MARK: - Cells size

extension AllDevicesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 30, height: 70)
        
    }
}
