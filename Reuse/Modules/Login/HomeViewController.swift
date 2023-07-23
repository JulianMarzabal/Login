//
//  ViewController.swift
//  Reuse
//
//  Created by Julian Marzabal on 01/06/2023.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin

class HomeViewController: UIViewController {
    private var viewmodel: HomeViewModel
    
    init(viewmodel: HomeViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = " Welcome Back"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 24)
        
        
        
       return label
    }()
    private lazy var  tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .black
        tableView.dataSource = self
        tableView.backgroundColor = .backgroundColor
        tableView.delegate = self
        tableView.registerCells()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
//
//    private lazy var googleSignInButton: GIDSignInButton = {
//        let button = GIDSignInButton()
//
//        button.addTarget(self, action: #selector(signinPressed), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    private lazy var googleSignInButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .backgroundColor
        button.setTitle("Sign In with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // Agregar la imagen del icono de Google al botón
        let googleIconImage = UIImage(named: "googleICON")
     

        let resizedImage = googleIconImage?.resizeUIImage(to: CGSize(width: 20, height: 20))
        button.setImage(resizedImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 12)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        button.addTarget(self, action: #selector(signinPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var facebookLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .backgroundColor
        button.setTitle("Sign In with Facebook", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        let facebookIconImage = UIImage(named: "FACEICON")
        let resizedImage = facebookIconImage?.resizeUIImage(to: CGSize(width: 20, height: 20))
        button.setImage(resizedImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 12)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12)
        button.addTarget(self, action: #selector(facebookSignInPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewmodel.onViewDidLoad()
        viewmodel.onFinishLoading = { [weak self] in
            self?.tableView.reloadData()
        }
       
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationItem.setHidesBackButton(true, animated: true)
//    }
    func configureUI() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(googleSignInButton)
        view.addSubview(facebookLoginButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 2),
            //google button
            
            googleSignInButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            googleSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            googleSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -350),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            facebookLoginButton.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor, constant: 20),
            facebookLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            facebookLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30)
        ])
    }
    
    @objc func signinPressed() {
        viewmodel.singinWithGoogle()
    }
    
    @objc func facebookSignInPressed() {
    
        viewmodel.signInWithFacebook()
    }
  
    
    


}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewmodel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        cell.selectionStyle = .none
        switch item {
        case let .input(text,inputType ,handler):
            guard let inputCell = cell as? TextFieldWrapper else {return UITableViewCell()}
            inputCell.configure(model: .init(placeholderText: text,handler: handler, inputType:inputType ))
            return inputCell
            
        case let .button(text, handler):
            guard let buttonCell = cell as? ButtonWrapper else {return UITableViewCell()}
            buttonCell.configure(model: .init(buttonTitle: text, handler: handler))
            
            
            return buttonCell
        case .label(text: let text):
            guard let labelCell = cell as? LabelWrapper else {return UITableViewCell()}
            labelCell.configure(model: .init(text: text, handler: nil))
            return labelCell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let startIndex = 0
//          let endIndex = 12
//          let interval = 2
//        cell.selectionStyle = .none
//        
//          
//          if indexPath.row >= startIndex && indexPath.row <= endIndex && (indexPath.row - startIndex) % interval == 0 {
//              // Ocultar el separador de la celda
//              cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
//          } else {
//              // Mostrar el separador de la celda
//              cell.separatorInset = UIEdgeInsets.zero
//          }
//    }
    
    
}
