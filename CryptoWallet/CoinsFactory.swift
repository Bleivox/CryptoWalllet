//
//  CoinsFactory.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 30.08.24.
//

import Foundation

class CoinsFactory: CoinsFactoryProtocol {
    
    
    private let coinLoader: CoinsLoader
    weak var delegate: CoinsFactoryDelegate?
    private var coins: [Coin] = []
    
    
    init(coinLoader: CoinsLoader, delegate: CoinsFactoryDelegate?) {
        self.coinLoader = coinLoader
        self.delegate = delegate
    }
    
    func loadData() {
        
        coinLoader.loadCoins { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let coins):
                    self.coins = coins.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
            
        }
    }
    
    func requestCoins() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let index = self.coins.count
            
            let coin = self.coins[index]
                    
            var imageData = Data()
            
            do {
                imageData = try Data(contentsOf: coin.image)
                
            } catch {
                print("Failed to load image")

            }
            let price = Float(coin.price) ?? 0
            
            let name = coin.name
            
            let coinForCell = CoinForCell(name: name, price: price, image: imageData)
    
        }
    }
}
