//
//  CoinsFactoryProtocol.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 30.08.24.
//

import Foundation
protocol CoinsFactoryProtocol {
    var delegate: CoinsFactoryDelegate? { get set }
    func requestCoins()
    func loadData()
}
