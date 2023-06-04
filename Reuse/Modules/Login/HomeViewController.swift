//
//  ViewController.swift
//  Reuse
//
//  Created by Julian Marzabal on 01/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    private var viewmodel: HomeViewModel
    
    init(viewmodel: HomeViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var emailTextField:UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = "Escribe tu email"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = "Escribe tu contraseña "
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.tintColor = .systemBlue
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    private func setupView(){
       
        title = "login"
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(button)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -60),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90)
        
        ])
    }
    
    @objc private  func buttonTapped() {
        guard let email = emailTextField.text,let password = passwordTextField.text else {return}
        if viewmodel.validateEmail(email: email) && viewmodel.validatePassword(password: password) {
            
            // Show other view
            print("es true")
        }
        else if !viewmodel.validateEmail(email: email) {
            print("email no valido")
        } else if !viewmodel.validatePassword(password: password){
            
            print("password no valida")
            
        }
        
        
    }
    
    


}

