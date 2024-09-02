//
//  CoinsCollectionViewCell.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 07.08.24.
//

import UIKit
import SnapKit

class CoinsCollectionViewCell: UICollectionViewCell {
    
    
   static let id = "CoinsCollectionViewCell"
    
    private var coins: [CoinForCell] = []
    
    var coinsName: UILabel = UILabel()
    var coinsPrice: UILabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func SetupCell(coins: CoinForCell) {
        contentView.addSubview(coinsName)
        contentView.addSubview(coinsPrice)
        coinsName.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(11)
        }
        coinsPrice.snp.makeConstraints{
            $0.right.top.bottom.equalToSuperview().inset(11)
        }
        self.coinsName.text = coins.name
        self.coinsPrice.text = "\(coins.price)"
        
    }
    

}
