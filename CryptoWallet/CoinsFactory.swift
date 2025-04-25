//
//  CoinsFactory.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 30.08.24.
//

import Foundation

class CoinsFactory: CoinsFactoryProtocol {
    
    
    private var coins: [Coin] = []
    
    private let coinLoader: CoinsLoader
    weak var delegate: CoinsFactoryDelegate?
    
    init(coinLoader: CoinsLoader, delegate: CoinsFactoryDelegate?) {
        self.coinLoader = coinLoader
        self.delegate = delegate
    }
    
    func loadData() {
        coinLoader.loadCoins { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let coinsArray):
                    self.coins = coinsArray // Теперь просто массив Coin
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
            
            guard !self.coins.isEmpty else {
                print("No coins available.")
                return
            }
        
            var coinsForCells: [CoinForCell] = []
            
            for coin in self.coins {
                var imageData = Data()
                
                do {
                    imageData = try Data(contentsOf: coin.image)
                } catch {
                    print("Failed to load image: \(error.localizedDescription)")
                    continue
                }
                
                let notRoundingPrice = Double(coin.price) ?? 0
                
                let price = round(notRoundingPrice * 100)/100.0
                let name = coin.name
                
                let coinForCell = CoinForCell(name: name, price: price, image: imageData)
                coinsForCells.append(coinForCell)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.didReceiveCoins(coins: coinsForCells)
            }
        }
    }
    
    
    
}
