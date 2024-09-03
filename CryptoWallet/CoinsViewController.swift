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
        coinsCollectionView.reloadData()
    }
    
    func didReceiveCoins(coins: CoinForCell?)  {
        guard let coins = coins else {
            return
        }
        
        let viewmodel = convert(model: coins)
    }
    
    func didFailToLoadData(with error: any Error) {
        let message = error.localizedDescription
    }
    
    private let coinsModel: CoinsViewModel
    private let userDefault = UserDefaults()
    private var coinsFactory: CoinsFactoryProtocol?
    private var logoutButton = UIButton()
    
    private lazy var coinsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGreen
        return collection
    }()
    
    init(coinsModel: CoinsViewModel) {
        self.coinsModel = coinsModel
        super.init(nibName: nil, bundle: nil)

        coinsFactory = CoinsFactory(coinLoader: CoinsLoader(), delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupViewModel()
        setupConstrains()
        self.coinsCollectionView.register(CoinsCollectionViewCell.self, forCellWithReuseIdentifier: CoinsCollectionViewCell.id)
        self.coinsCollectionView.dataSource = self
        self.coinsCollectionView.delegate = self
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
        return coinsFactory?.coins.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinsCollectionViewCell.id, for: indexPath) as? CoinsCollectionViewCell,
              let cellViewModel = coinsFactory?.coins[indexPath.item]
        else { return .init() }
        
        cell.setupCell(coins: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

    // UICollectionView
