//
//  CoinsViewModel.swift
//  CryptoWallet
//
//  Created by Vadim Chistiakov on 19.07.2024.
//

import Foundation

class CoinsViewModel {
    
    private let router: CoinsRouter
    
    init(router: CoinsRouter) {
        self.router = router
    }
    
    func goToMain() {
        
        router.goToMain()
    }
}
