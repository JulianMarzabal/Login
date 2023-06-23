//
//  FirstViewController.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import UIKit
import CoreML

class FirstViewController: UIViewController {
    var viewmodel: FirstViewViewModel
    var photoModel: myPhotoModel?
    init(viewmodel: FirstViewViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Select Image"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "inputCar")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var pickerView:UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self

        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.fetchPhotos()
        setupUI()
        setContraints()
        viewmodel.modeling()
        setupImage()
      
        

      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    private func setupUI() {
        title = "Core ML"
        view.backgroundColor = .green
        view.addSubview(label)
        view.addSubview(imageView)
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
    
    }
    @objc private func didTapImage(){
        present(pickerView, animated: true)
    }
   private  func setContraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 300), // Ancho de la imagen
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
            
        ])
    }
    
    func setupImage() {
        guard let url = URL(string: viewmodel.myPhotoModel.first?.url ?? "") else {return}
        print("A CONTINUACION LA URL")
        print(url)
        imageView.sd_setImage(with: url)
    }
    
    
    
    
    

    

}

extension FirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        
        imageView.image = image
    }
    
    
}
