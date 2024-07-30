//
//  CustomTextField.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 27.07.24.
//

import Foundation
import UIKit
import SnapKit

// TODO: - проверить констреинты
// доделать логику скрытия/показа ошибок

class UITextFieldsWithError: UITextField {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlue
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
        }
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
    }
        
    func showError(_ text: String) {
        errorLabel.text = text
        errorLabel.isHidden = false
    }
        
    func hideError() {
        errorLabel.isHidden = true
    }
}
