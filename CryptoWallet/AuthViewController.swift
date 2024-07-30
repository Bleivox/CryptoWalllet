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
    
    private let loginLabel: UILabel = UILabel()
    
    private let loginTextField: UITextField = UITextField()
    
    private let passwordLabel: UILabel = UILabel()
    
    private let passwordTextField: UITextField = UITextField()
    
    private let loginButton: UIButton = UIButton()
    
    private let errorText: UILabel = UILabel()
    
    let userDefaults =  UserDefaults()
    
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
                
        
        loginLabel.text = "Email"
                loginLabel.textColor = .ypBlue
                loginLabel.font = .boldSystemFont(ofSize: 13)
                view.addSubview(loginLabel)
        
        
        passwordLabel.text = "Password"
                passwordLabel.textColor = .ypBlue
                passwordLabel.font = .boldSystemFont(ofSize: 13)
                view.addSubview(passwordLabel)
        
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
        errorText.isHidden = true
    
        loginTextField.snp.makeConstraints { (maker) in
            
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.top.equalTo(view.safeAreaLayoutGuide).inset(410)
            maker.bottom.equalTo(view.safeAreaLayoutGuide).inset(300)

        }
        
        passwordTextField.snp.makeConstraints{ (maker) in
            
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.width.equalTo(loginTextField.snp.width)
            maker.height.equalTo(loginTextField.snp.height)
            maker.top.equalTo(loginTextField.snp.bottom).inset(-30)
            
            
        }
               
        loginLabel.snp.makeConstraints{ (maker) in
         
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(18)
            maker.bottom.equalTo(loginTextField.snp.top).inset(-2)
            
        }
                
        passwordLabel.snp.makeConstraints{ (maker) in
            
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(18)
            maker.bottom.equalTo(passwordTextField.snp.top).inset(-2)
            
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

    func SuccessAfterError() {
        
        passwordTextField.layer.borderColor = UIColor.ypBlue.cgColor
        
        errorText.isHidden = true

        
    }
  
    func dropError() {
        
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        
        errorText.isHidden = false
        errorText.text = "Enter a valid password"
        errorText.textColor = UIColor.red
        errorText.font = .systemFont(ofSize: 13)
        view.addSubview(errorText)
        
        
        errorText.snp.makeConstraints{ (maker) in
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(18)
            maker.top.equalTo(passwordTextField.snp.bottom).offset(2)
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
    
    
    func proofAuthorisation(AuthViewModel: AuthViewModel) {
        
        if passwordTextField.text == AuthViewModel.password && loginTextField.text == AuthViewModel.login {
            print("success")
            userDefaults.set(passwordTextField.text, forKey: Keys.password.rawValue)
            userDefaults.set(loginTextField.text, forKey: Keys.login.rawValue)
            
            
        }
        else {
            dropError()
            print("false password or login")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) { [weak self] in
                guard let self = self else { return }
                self.SuccessAfterError()
                
            }
            
        }
        
    }
    
    
    
    @objc func loginMove() {
        
        proofAuthorisation(AuthViewModel: AuthViewModel(login: "1234", password: "1234"))
        
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
