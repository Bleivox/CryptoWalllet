//
//  AuthViewController.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 05.07.24.
//

import UIKit
import SnapKit

// Если флаг isAuth == true - то показываем экран с монетами сразу
    // Если на экране монет нажали кнопку логаут то возвращаемся на экран авторизации
// Если флаг isAuth == false - то показываем экран с арторизацией
    // После авторизации сохранять флаг в тру

//    enum State {
//        case success(text: String)
//        case failure(errorMessage: String)
//    }
//    
//    
//    /// обрабатывает состояние ошибки
//    
//}

// Прочитать про Result
//enum Result<Success, Failure: Error> {
//    case success(Success)
//    case failure(Failure)
//}

// View --> ViewModel --> Coordinator
// MVVM - архитектура
// View == ViewController
// ViewModel -> ViewController имеет ссылку на вью
// ViewModel -> Не знает о view или ViewController
// ViewModel - может оповестить ViewController об изменениях
// ViewModel через замыкание оповещает вью об изменениях


class AuthViewController: UIViewController {
    
    
    
    private let mainLabel: UILabel = UILabel()
    private let loginTextField = UITextFieldsWithError(title: "Email")
    private let passwordTextField = UITextFieldsWithError(title: "Password")
    private let loginButton: UIButton = UIButton()
    
    let userDefaults =  UserDefaults()
    
    private let viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func method(param: String, closure: (String) -> Void) {
//        print(param)
//        closure("param")
//    }
    
    func isAuth() {
        
        if userDefaults.string(forKey: Keys.password.rawValue) == "1234" && userDefaults.string(forKey: Keys.login.rawValue) == "1234" {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) { [weak self] in
                guard let self = self else { return }
                viewModel.goToCoins()
            }
        } else {
            
        }
    }
    
//   enum Keys: String {
//        case password, login
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupViewController()
         setupViewModel()
         setupConstrains()
        // startLoading()
        
        isAuth()
    }
    
    private func setupAuthViewModel() {
        
        
        
        
    }
    
    private func setupViewController() {
        
        view.backgroundColor = .white
        
    }
    
    private func setupViewModel() {
        
        loginTextField.layer.borderColor = UIColor.ypBlue.cgColor
        loginTextField.layer.borderWidth = 1.75
        loginTextField.layer.cornerRadius = 5
        loginTextField.dropShadow()
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        view.addSubview(loginTextField)
        
        
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderColor = UIColor.ypBlue.cgColor
        passwordTextField.layer.borderWidth = 1.75
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.dropShadow()
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        view.addSubview(passwordTextField)
        
        mainLabel.text = "Welcome!"
                mainLabel.textColor = .ypBlue
                mainLabel.font = .boldSystemFont(ofSize: 30)
                view.addSubview(mainLabel)

        loginButton.setTitle("Log In", for: .normal)
                loginButton.setTitleColor(.white, for: .normal)
                loginButton.addTarget(self, action: #selector(loginMove), for: .touchUpInside)
                loginButton.backgroundColor = .ypBlue
                loginButton.layer.cornerRadius = 16
                loginButton.layer.masksToBounds = true
                loginButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
                view.addSubview(loginButton)
    }
    private func setupConstrains() {
        loginTextField.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(410)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(270)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints{
            $0.right.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
            $0.top.equalTo(loginTextField.snp.bottom).inset(-35)
        }
        
        mainLabel.snp.makeConstraints{
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(125)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(125)
            $0.bottom.equalTo(loginTextField.snp.top).inset(-25)
        }
        
        loginButton.snp.makeConstraints{
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(110)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(110)
            $0.height.equalTo(50)
            $0.top.equalTo(passwordTextField.snp.bottom).inset(-30)
            
        }
    }

    func successAfterError() {
        
        passwordTextField.layer.borderColor = UIColor.ypBlue.cgColor
        loginTextField.layer.borderColor = UIColor.ypBlue.cgColor
        loginTextField.hideError()
        passwordTextField.hideError()
    }
  
    func dropError(isPasswordValid: Bool, isLoginValid: Bool) {
        // TODO: - доделать очистку ошибки
        if !isPasswordValid {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.showError("Enter a valid password")
        }
        if !isLoginValid {
            loginTextField.layer.borderColor = UIColor.red.cgColor
            loginTextField.showError("Enter a valid login")
        }
    }
    
//    func auth() {
//        do {
//            let isValid = try checkPassword("1234")
//            print(isValid)
//        } catch {
//            print("\(error) password doesn't equal to 1234")
//        }
//    }
//    
//    func checkPassword(_ password: String) throws -> Bool  {
//        if password == "1234" {
//            return true
//        } else {
//            throw CustomError.wrongPassword
//        }
//    }
//    
//    enum CustomError: Error {
//        case wrongPassword
//    }
//    
    
    
    
    func proofAuthorisation(authModel: AuthModel) {
        
        if passwordTextField.text == authModel.password && loginTextField.text == authModel.login {
            print("success")
            userDefaults.set(passwordTextField.text, forKey: Keys.password.rawValue)
            userDefaults.set(loginTextField.text, forKey: Keys.login.rawValue)
            // show next screen
            viewModel.goToCoins()
            passwordTextField.text = ""
            loginTextField.text = ""
        }
        else {
            dropError(
                isPasswordValid: passwordTextField.text == authModel.password,
                isLoginValid: loginTextField.text == authModel.login
            )
            print("false password or login")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) { [weak self] in
                guard let self = self else { return }
                self.successAfterError()
            }
        }
    }
    
    
    
    @objc func loginMove() {
        proofAuthorisation(authModel: AuthModel(login: "1234", password: "1234"))
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
