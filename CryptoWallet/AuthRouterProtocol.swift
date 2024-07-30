//
//  AuthRouterProtocol.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 27.07.24.
//

import Foundation

public protocol AuthRouterProtocol  {
  
    func order(message: String, completion: @escaping (Result< String , Error>) -> Void)
    
}

