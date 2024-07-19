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

class TextFieldWithError: UITextField {
    
    enum State {
        case success(text: String)
        case failure(errorMessage: String)
    }
    
    
    /// обрабатывает состояние ошибки
    
}

// Прочитать про Result
enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

// View --> ViewModel --> Coordinator
// MVVM - архитектура
// View == ViewController
// ViewModel -> ViewController имеет ссылку на вью
// ViewModel -> Не знает о view или ViewController
// ViewModel - может оповестить ViewController об изменениях
// ViewModel через замыкание оповещает вью об изменениях


class ViewController: UIViewController {
    
// Segue надо удалить. Роутеры и координаторы - прочитать.
// Router in ios Swift. Coordinator vs Router
    
    let showCoinsSegueIdentifier = "showCoins"
    
    // Убрать @IBOutlet и сделать всю верстку в коде. Сториборды удалить
    @IBOutlet weak var loginTextField: UITextField!
//    private let loginTextField: UITextField = UITextField()
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorText: UILabel!
    
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
        
        errorText.isHidden = true
        
        
        loginTextField.layer.borderColor = UIColor.ypBlue.cgColor
        loginTextField.layer.borderWidth = 1.75
        loginTextField.layer.cornerRadius = 5
        loginTextField.dropShadow()
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        
        loginTextField.snp.makeConstraints { (maker) in
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.top.equalTo(view.safeAreaLayoutGuide).inset(410)
            maker.bottom.equalTo(view.safeAreaLayoutGuide).inset(300)

        }
        
        
        
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderColor = UIColor.ypBlue.cgColor
        passwordTextField.layer.borderWidth = 1.75
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.dropShadow()
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints{ (maker) in
            
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            maker.width.equalTo(loginTextField.snp.width)
            maker.height.equalTo(loginTextField.snp.height)
            maker.top.equalTo(loginTextField.snp.bottom).inset(-30)
            
            
        }
               
        let loginLabel = UILabel()
        
        loginLabel.text = "Email"
        loginLabel.textColor = .ypBlue
        loginLabel.font = .boldSystemFont(ofSize: 13)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        loginLabel.snp.makeConstraints{ (maker) in
         
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(18)
            maker.bottom.equalTo(loginTextField.snp.top).inset(-2)
            
        }
                
        
        let passwordLabel = UILabel()
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .ypBlue
        passwordLabel.font = .boldSystemFont(ofSize: 13)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        passwordLabel.snp.makeConstraints{ (maker) in
            
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(18)
            maker.bottom.equalTo(passwordTextField.snp.top).inset(-2)
            
        }
        
     
        let mainLabel = UILabel()
        
        mainLabel.text = "Welcome!"
        mainLabel.textColor = .ypBlue
        mainLabel.font = .boldSystemFont(ofSize: 30)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints{ (maker) in
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(125)
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(125)
            maker.bottom.equalTo(loginTextField.snp.top).inset(-25)
        }
              
        
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginMove), for: .touchUpInside)
        loginButton.backgroundColor = .ypBlue
        loginButton.layer.cornerRadius = 16
        loginButton.layer.masksToBounds = true
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints{ (maker) in
            
            maker.left.equalTo(view.safeAreaLayoutGuide).inset(110)
            maker.right.equalTo(view.safeAreaLayoutGuide).inset(110)
            maker.height.equalTo(50)
            maker.top.equalTo(passwordTextField.snp.bottom).inset(-30)
            
        }
     
//        isAuth()
    }

    func SuccessAfterError() {
        
        passwordTextField.layer.borderColor = UIColor.ypBlue.cgColor
        
        errorText.isHidden = true

        
    }
  
    func dropError() {
        passwordTextField.backgroundColor = .red
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        
        errorText.isHidden = false
        errorText.text = "Enter a valid password"
        errorText.textColor = UIColor.red
        errorText.font = .systemFont(ofSize: 13)
        errorText.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    func proofAuthorisation(Person: Person) {
        
        if passwordTextField.text == Person.password && loginTextField.text == Person.login {
            print("success")
            performSegue(withIdentifier: showCoinsSegueIdentifier, sender: nil)
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
        
        
        
    }
    
    
    
    @IBAction private func loginButton(_: Any ) {
        
       proofAuthorisation(Person: Person(login: "1234", password: "1234"))
        
    }
    

}


class CustomPasswordTextField: ViewController {
    
    
    
    
//    func dropError() {
//        
//        passwordTextField.layer.borderColor = UIColor.red.cgColor
//        
//        var errorText = UILabel()
//        errorText.text = "Enter a valid password"
//        errorText.textColor = UIColor.red
//        errorText.font = .systemFont(ofSize: 13)
//        errorText.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        errorText.snp.makeConstraints{ (maker) in
//            maker.left.equalTo(view.safeAreaLayoutGuide).inset(18)
//            maker.top.equalTo(passwordTextField.snp.bottom).inset(-2)
//        }
//        
//        
//        
//    }
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
