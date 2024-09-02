//
//  NetworkClient.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 30.08.24.
//

import Foundation

protocol NetworkRouting {
    
    func fetch(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void)
    
}

struct NetworkClient: NetworkRouting {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) {
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
               }
            guard let data = data else { return }
            handler(.success(data))
        }.resume()
        
    }
}
