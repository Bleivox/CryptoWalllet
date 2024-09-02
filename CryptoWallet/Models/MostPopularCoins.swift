//
//  MostPopularCoins.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 24.08.24.
//

import Foundation
import UIKit

struct Coins: Codable {
    
    let errorMassage: String
    let items: [Coin]
    
}

struct Coin: Codable {
    let name: String
    let price: String
    let image: URL
    
    
    private enum CodingKeys: String, CodingKey {
        case name = "symbol"
        case price = "usd_price"
        case image = "logo"
        
    }
    
}

protocol CoinsLoading {
    func loadCoins(handler: @escaping (Result<[Coin], Error>) -> Void)
}


struct CoinsLoader: CoinsLoading {
        
       private let networkClient: NetworkRouting
        
        init(networkClient: NetworkRouting = NetworkClient()) {
            self.networkClient = networkClient
        }
        
        
        private var mostPopularCoinsUrl: URLRequest {
            guard let url = URL(string: "https://deep-index.moralis.io/api/v2.2/market-data/global/market-cap") else {
                preconditionFailure("Unable to construct mostPopularCoinsUrl")
            }
                
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "x-api-key": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6Ijk1ZDZjZmRmLTliZGMtNDdhNi1hNWZkLTZiODRmOGYyODg1YSIsIm9yZ0lkIjoiNDA1ODYxIiwidXNlcklkIjoiNDE3MDQ1IiwidHlwZUlkIjoiZTBkMzMwMDAtMDIxZC00OTYxLWI0NmItMmIxYWEzZjAzYzYwIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3MjQ1ODIzMzEsImV4cCI6NDg4MDM0MjMzMX0.zfynx8t3OvbO4UNFaLkXAuc-4dvxMpgHUvTTDnr0dHA"
                    ]
            return request
        }
        
        
        func loadCoins(handler: @escaping (Result<[Coin], Error>) -> Void) {
            networkClient.fetch(request: mostPopularCoinsUrl) { result in
                switch result {
                case .success(let data):
                    do {
                        let mostPopularCoins = try JSONDecoder().decode([Coin].self, from: data)
                        handler(.success(mostPopularCoins))
                    } catch {
                        handler(.failure(error))
                    }
                case .failure(let error):
                    handler(.failure(error))
                }
            }
            
            
            
        }
        
    }


//class CoinMarket {
//    
//    var coins = [Coin]()
//    
//    init() {
//        setup()
//    }
    
//    func setup() {
//        
//        let coin1 = Coins(name: "btc", price: 48000)
//        let coin2 = Coins(name: "eth", price: 20000)
//        let coin3 = Coins(name: "ton", price: 27989)
//        self.coins = [coin1,coin2,coin3]
//        
//    }
//    
//}
