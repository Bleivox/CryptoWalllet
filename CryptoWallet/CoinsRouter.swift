//
//  CoinsRouter.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 27.07.24.
//

import Foundation
import UIKit

class CoinsRouter {
    
    private let navigationController: UINavigationController
     
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(viewController: UIViewController , animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func goToMain() {
        navigationController.popViewController(animated: true)
    }
    
}
