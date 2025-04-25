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
        
    var coinsName: UILabel = UILabel()
    var coinsPrice: UILabel = UILabel()
    var coinImage: UIImageView = UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(coinsName)
        contentView.addSubview(coinsPrice)
        contentView.addSubview(coinImage)
        coinsName.snp.makeConstraints{
            $0.left.top.bottom.equalToSuperview().inset(11)
        }
        coinsPrice.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview().inset(11)
        }
        
        coinImage.snp.makeConstraints {
            $0.left.equalTo(coinsName.snp.right).inset(-10)
            $0.top.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            
            
                    }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCell(coins: CoinsStepViewModel) {
        
        self.coinsName.text = coins.name
        self.coinsName.textColor = .blue
        
        self.coinsPrice.text = "\(coins.price)"
        self.coinImage.image = coins.image 
    }

}
