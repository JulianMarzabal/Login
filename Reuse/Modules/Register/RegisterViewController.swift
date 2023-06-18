//
//  RegisterViewController.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    var viewmodel: RegisterViewModel
    
    init(viewmodel:RegisterViewModel) {
        
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 30)
        
        
        
       return label
    }()
    
    private lazy var  tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextFieldWrapper.self, forCellReuseIdentifier: TextFieldWrapper.identifier)
        tableView.register(LabelWrapper.self, forCellReuseIdentifier: LabelWrapper.identifier)
        tableView.register(ButtonWrapper.self, forCellReuseIdentifier: ButtonWrapper.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewmodel.onViewDidLoad()
        viewmodel.onFinishLoading = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        let loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginButtonTapped))
        navigationItem.rightBarButtonItem = loginButton
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 2),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30)
        ])
    }
    
    @objc private func loginButtonTapped() {
        viewmodel.delegate?.toLoginView()
    }
    
    

    
  

}

extension RegisterViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewmodel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        cell.selectionStyle = .none
    
        switch item {
        case let .input(text,inputType, handler):
            guard let inputCell = cell as? TextFieldWrapper else {return UITableViewCell()}
            inputCell.configure(model: .init(placeholderText: text, handler: handler, inputType:inputType ))
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
        1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
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

