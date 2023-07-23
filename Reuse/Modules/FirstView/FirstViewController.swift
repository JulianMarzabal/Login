//
//  FirstViewController.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import UIKit
import CoreML
import SkeletonView

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
        label.text = "Next Image"
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 22)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.forward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let resizedImage = image?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), resizingMode: .stretch)
           button.setImage(resizedImage, for: .normal)
        button.addTarget(self, action: #selector(nextPrediction), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var pickerView:UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self

        return picker
    }()
    lazy var predictionLabel: UILabel = {
        let label = UILabel()
       
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var probabilityLabel: UILabel = {
        let label = UILabel()
       
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindReaction()
        viewmodel.fetchPhotos()
        setupUI()
        setContraints()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    private func setupUI() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 20)!]
         navigationController?.navigationBar.titleTextAttributes = attributes
         navigationItem.title = "Object recognition"
        
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(label)
        view.addSubview(nextButton)
        view.addSubview(imageView)
        view.addSubview(predictionLabel)
        view.addSubview(probabilityLabel)
   
     
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
    
    }
    @objc private func didTapImage(){
        present(pickerView, animated: true)
    }
   private  func setContraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 350), // Ancho de la imagen
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 10),
            nextButton.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100), // Ancho deseado del botón
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            predictionLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor,constant: 30),
            predictionLabel.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            probabilityLabel.topAnchor.constraint(equalTo: predictionLabel.bottomAnchor,constant: 10),
            probabilityLabel.centerXAnchor.constraint(equalTo: predictionLabel.centerXAnchor),
         
            
        ])
    }
    

   @objc func nextPrediction() {
       viewmodel.processImage()
       
    }
    
    func bindReaction() {
        viewmodel.onNextImageHandler = {[weak self] imageModel in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.imageView.sd_setImage(with: imageModel.image)
                self.predictionLabel.text = imageModel.predictionText
                self.probabilityLabel.text = imageModel.probabilityText
            }
          
        }
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
