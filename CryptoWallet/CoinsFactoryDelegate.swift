//
//  CoinsFactoryDelegate.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 30.08.24.
//

import Foundation

protocol CoinsFactoryDelegate: AnyObject {
    func didLoadDataFromServer()
//    func didFailToLoadData(with error: Error)
}
