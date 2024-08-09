//
//  CoinsViewController.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 15.07.24.
//

import Foundation
import UIKit
import SnapKit

final class CoinsViewController: UIViewController {
    
    private let coinsModel: CoinsViewModel
    private let userDefault = UserDefaults()
//    private let coinsCollectionView: UICollectionView = UICollectionView()
    
    
    init(coinsModel: CoinsViewModel) {
        self.coinsModel = coinsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupViewModel()
        setupConstrains()
//        self.coinsCollectionView.register(UINib(nibName: "CoinsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoinsCollectionViewCell")
//        self.coinsCollectionView.dataSource = self
//        self.coinsCollectionView.delegate = self
    }
    
    private var logoutButton = UIButton()
    
    
    func setupViewModel(){
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        view.addSubview(logoutButton)
        
        
    }
    
    private func setupConstrains() {
        
//        coinsCollectionView.snp.makeConstraints{
//            $0.right.left.bottom.top.equalToSuperview()
//        }
        
        logoutButton.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
    }
    
    @objc func logout() {
        coinsModel.goToMain()
        userDefault.removeObject(forKey: Keys.password.rawValue)
        userDefault.removeObject(forKey: Keys.login.rawValue)
        
    }
    
}

//extension CoinsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        return
////    }
//    
//    
//}

    // UICollectionView
