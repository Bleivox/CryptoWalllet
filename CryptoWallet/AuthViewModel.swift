//
//  AuthViewModel.swift
//  CryptoWallet
//
//  Created by Vadim Chistiakov on 19.07.2024.
//

import Foundation

struct AuthModel {
    
    var login: String
    var password: String
    
}

class AuthViewModel {
    
    private let router: AuthRouter
    
    init(router: AuthRouter) {
        self.router = router
    }
    
    func goToCoins() {
        router.goToCoins()
    }
}
