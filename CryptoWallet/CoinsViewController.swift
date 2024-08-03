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
        
        logoutButton.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
    }
    
    @objc func logout() {
        coinsModel.goToMain()
        
    }
    
}

    // UICollectionView
