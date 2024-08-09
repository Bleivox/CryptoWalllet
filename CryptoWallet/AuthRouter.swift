//
//  AuthRouter.swift
//  CryptoWallet
//
//  Created by Vadim Chistiakov on 30.07.2024.
//

import UIKit

class AuthRouter: CoinsRouter {
    
    
    func goToCoins() {
        let coinsViewModel = CoinsViewModel(router: self)
        
                let coins = CoinsViewController(coinsModel: coinsViewModel)
                navigationController.pushViewController(coins, animated: true)

    }
    
}
