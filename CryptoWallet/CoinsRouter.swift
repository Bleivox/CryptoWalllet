//
//  CoinsRouter.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 27.07.24.
//

import Foundation
import UIKit

final class CoinsRouter {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToMain() {
        let main = AuthViewController(viewModel: viewModel)
        navigationController.pushViewController(main, animated: true)
    }
    
}
