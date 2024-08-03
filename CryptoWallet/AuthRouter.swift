//
//  AuthRouter.swift
//  CryptoWallet
//
//  Created by Vadim Chistiakov on 30.07.2024.
//

import UIKit

final class AuthRouter {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToCoins() {
        let coins = CoinsViewController(coinsModel: coinsModel )
        navigationController.pushViewController(coins, animated: true)
    }
    
}
