//
//  CoinsViewController.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 15.07.24.
//

import Foundation
import UIKit
import SnapKit

final class CoinsViewController: UIViewController, CoinsFactoryDelegate {
    
    func didLoadDataFromServer() {
        coinsFactory?.requestCoins()
    }
    
    func didReceiveCoins(coins: [CoinForCell]) {
        self.currentCoin = coins
        coinsCollectionView.reloadData()
    }
    
    func didFailToLoadData(with error: any Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            present(alert, animated: true)
    }
    
    private let coinsModel: CoinsViewModel
    private let userDefault = UserDefaults()
    private var coinsFactory: CoinsFactoryProtocol?
    private var logoutButton = UIButton()
    private var currentCoin: [CoinForCell] = []

    
    
    private lazy var coinsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    init(coinsModel: CoinsViewModel) {
        self.coinsModel = coinsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupConstrains()
        self.coinsCollectionView.register(CoinsCollectionViewCell.self, forCellWithReuseIdentifier: CoinsCollectionViewCell.id)
        coinsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        self.coinsCollectionView.dataSource = self
        self.coinsCollectionView.delegate = self
        coinsFactory = CoinsFactory(coinLoader: CoinsLoader(), delegate: self)
        coinsFactory?.loadData()
    }
    
    func convert(model: CoinForCell) -> CoinsStepViewModel{
        
        let coin = CoinsStepViewModel(image: UIImage(data: model.image) ?? UIImage(),
                                       name: model.name,
                                       price: model.price)
        return coin
        
    }
    
    func setupViewModel(){
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        view.addSubview(logoutButton)
        view.addSubview(coinsCollectionView)
        
        
    }
    
    private func setupConstrains() {
        
        coinsCollectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    @objc func logout() {
        coinsModel.goToMain()
        userDefault.removeObject(forKey: Keys.password.rawValue)
        userDefault.removeObject(forKey: Keys.login.rawValue)
        
    }
    
}

extension CoinsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCoin.isEmpty ? 1 : currentCoin.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if currentCoin.isEmpty {
                    // Показать пустой или индикатор загрузки
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
                    cell.backgroundColor = .lightGray // Можно поставить индикатор загрузки или пустое сообщение
                    return cell
                }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinsCollectionViewCell.id, for: indexPath) as? CoinsCollectionViewCell
        
        else { return UICollectionViewCell() }
        
        let coinModel = currentCoin[indexPath.item]
        cell.setupCell(coins: convert(model: coinModel))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

