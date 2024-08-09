//
//  CoinsRouter.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 27.07.24.
//

import Foundation
import UIKit

 class CoinsRouter {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToMain() {
        navigationController.popViewController(animated: true)
    }
    
}
