//
//  AuthViewController.swift
//  CryptoWallet
//
//  Created by Никита Долгов on 05.07.24.
//

import UIKit
import SnapKit

// В AppDelegate проверять флаг в юзердефолтс
// Если флаг isAuth == true - то показываем экран с монетами сразу
    // Если на экране монет нажали кнопку логаут то возвращаемся на экран авторизации
// Если флаг isAuth == false - то показываем экран с арторизацией
    // После авторизации сохранять флаг в тру

// Как сделать кастомный текст филд с обработкой ошибки?
//class TextFieldWithError: UITextField {
//    
//    // UILabel - title
//    // Constrainst
//    // UITextField
//    // Constrainst
//    // UILabel - optional error
//    // Constrainst
//    
//    // логика самого текст филда
//    // добавить лэбл с ошибкой
//    // обрабатывать состояния показа ошибки
//    // констреинты между текстфилдом и лэйблом ошибки
//    
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
    
// Segue надо удалить. Роутеры и координаторы - прочитать.
// Router in ios Swift. Coordinator vs Router
    
    // Убрать @IBOutlet и сделать всю верстку в коде. Сториборды удалить
    
    private let mainLabel: UILabel = UILabel()
    private let loginTextField = UITextFieldsWithError(title: "email")
    private let passwordTextField = UITextFieldsWithError(title: "password")
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
    
//    var isAuth =  Bool {
//        
//        
//        if userDefaults.bool(forKey: Keys.password.rawValue) == userDefaults.bool(forKey: Keys.login.rawValue) {
//            performSegue(withIdentifier: showCoinsSegueIdentifier, sender: nil)
//        }
//        
//    
//    }
    
//    func method(param: String, closure: (String) -> Void) {
//        print(param)
//        closure("param")
//    }
    
    private enum Keys: String {
        case password, login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupViewController()
         setupViewModel()
        setupConstrains()
        // startLoading()
//        isAuth()
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(300)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints{
            $0.right.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
            $0.top.equalTo(loginTextField.snp.bottom).inset(-30)
        }
        
        mainLabel.snp.makeConstraints{ (maker) in
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(125)
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(125)
            maker.bottom.equalTo(loginTextField.snp.top).inset(-25)
        }
        
        loginButton.snp.makeConstraints{ (maker) in
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(110)
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(110)
            maker.height.equalTo(50)
            maker.top.equalTo(passwordTextField.snp.bottom).inset(-30)
            
        }
    }

    func successAfterError() {
        
        passwordTextField.layer.borderColor = UIColor.ypBlue.cgColor
        loginTextField.hideError()
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
    
    func auth() {
        do {
            let isValid = try checkPassword("1234")
            print(isValid)
        } catch {
            print("\(error) password doesn't equal to 1234")
        }
    }
    
    func checkPassword(_ password: String) throws -> Bool  {
        if password == "1234" {
            return true
        } else {
            throw CustomError.wrongPassword
        }
    }
    
    enum CustomError: Error {
        case wrongPassword
    }
    
    // Errors thrown from here are not handled because the enclosing catch is not exhaustive
    
    
    func proofAuthorisation(authModel: AuthModel) {
        
        if passwordTextField.text == authModel.password && loginTextField.text == authModel.login {
            print("success")
            userDefaults.set(passwordTextField.text, forKey: Keys.password.rawValue)
            userDefaults.set(loginTextField.text, forKey: Keys.login.rawValue)
            // show next screen
            viewModel.goToCoins()
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
