//
//  AuthorizationViewController.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/26/24.
//

import UIKit

class AuthorizationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    private let mainStackView = UIStackView()
    private let imageButtonStackView = UIStackView()
    private let imageButton = UIButton()
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordCheckLabel = UILabel()
    private let passwordCheckTextField = UITextField()
    private let logInButton = UIButton()
    var countriesListViewController = CountriesListViewController()
    var viewModel = AuthorizationViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        loadImageFromDocuments()
    }
    
    // MARK: - Setup
    private func setup() {
        setupImageButtonStackView()
        setupMainStackView()
        setupImageButton()
        setupNameLabel()
        setupNameTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupPasswordCheckLabel()
        setupPasswordCheckTextField()
        setupLogInButton()
        
        mainStackView.setCustomSpacing(6, after: nameLabel)
        mainStackView.setCustomSpacing(30, after: nameTextField)
        mainStackView.setCustomSpacing(6, after: passwordLabel)
        mainStackView.setCustomSpacing(30, after: passwordTextField)
        mainStackView.setCustomSpacing(6, after: passwordCheckLabel)
        mainStackView.setCustomSpacing(50, after: passwordCheckTextField)
        
    }
    
    private func setupImageButtonStackView() {
        view.addSubview(imageButtonStackView)
        
        imageButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        imageButtonStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        imageButtonStackView.isLayoutMarginsRelativeArrangement = true
        imageButtonStackView.layoutMargins = UIEdgeInsets(top: 50, left: 120, bottom: 0, right: 120)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped))
        imageButton.addGestureRecognizer(tapGesture)
        imageButton.isUserInteractionEnabled = true
    }
    
    @objc private func imageButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageButton.setImage(selectedImage, for: .normal)
            saveImageToDocuments(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveImageToDocuments(image: UIImage) {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentsDirectory.appendingPathComponent("profileImage.png")
        guard let imageData = image.pngData() else { return }
        
        if fileManager.fileExists(atPath: imageURL.path) {
            do {
                try fileManager.removeItem(at: imageURL)
            } catch {
                print(error)
            }
        }
        
        do {
            try imageData.write(to: imageURL)
        } catch {
            print(error)
        }
    }
    
    private func loadImageFromDocuments() {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentsDirectory.appendingPathComponent("profileImage.png")
        
        if fileManager.fileExists(atPath: imageURL.path) {
            if let imageData = try? Data(contentsOf: imageURL),
               let image = UIImage(data: imageData) {
                imageButton.setImage(image, for: .normal)
            }
        }
    }
    
    // MARK: - Private Methods
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: imageButtonStackView.bottomAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(top: 46, left: 24, bottom: 0, right: 24)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageButton.layer.borderColor = UIColor(named: "sfSymbol")?.resolvedColor(with: self.traitCollection).cgColor
    }
    
    private func setupImageButton() {
        imageButton.widthAnchor.constraint(equalToConstant: 132).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 132).isActive = true
        imageButton.layer.borderWidth = 1.5
        imageButton.layer.borderColor = UIColor(named: "sfSymbol")?.cgColor
        imageButton.backgroundColor = .clear
        let image = UIImage(systemName: "person.crop.circle.fill.badge.plus")?
            .withRenderingMode(.alwaysTemplate)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 70, weight: .regular))
        imageButton.setImage(image, for: .normal)
        imageButton.tintColor = UIColor(named: "sfSymbol")
        imageButton.backgroundColor = UIColor(named: "imageButtonBackground")
        
        imageButtonStackView.addArrangedSubview(imageButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageButton.layer.cornerRadius = imageButton.frame.width / 2
        imageButton.layer.masksToBounds = true
    }
    
    private func setupNameLabel() {
        nameLabel.text = "მომხმარებლის სახელი"
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textColor = UIColor(named: "textColor")
        
        mainStackView.addArrangedSubview(nameLabel)
    }
    
    private func setupNameTextField() {
        mainStackView.addArrangedSubview(nameTextField)
        
        nameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 326).isActive = true
        
        nameTextField.backgroundColor = UIColor(named: "textFieldColor")
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "შეიყვანეთ მომხმარებლის სახელი",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholder")]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.font = UIFont.systemFont(ofSize: 12)
        nameTextField.layer.cornerRadius = 20
    }
    
    private func setupPasswordLabel() {
        passwordLabel.text = "პაროლი"
        passwordLabel.font = .systemFont(ofSize: 12)
        passwordLabel.textColor = UIColor(named: "textColor")
        
        mainStackView.addArrangedSubview(passwordLabel)
    }
    
    private func setupPasswordTextField() {
        mainStackView.addArrangedSubview(passwordTextField)
        
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 326).isActive = true
        
        passwordTextField.backgroundColor = UIColor(named: "textFieldColor")
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "შეიყვანეთ მომხმარებლის სახელი",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholder")]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.font = UIFont.systemFont(ofSize: 12)
        passwordTextField.layer.cornerRadius = 20
    }
    
    private func setupPasswordCheckLabel() {
        passwordCheckLabel.text = "გაიმეორეთ პაროლი"
        passwordCheckLabel.font = .systemFont(ofSize: 12)
        passwordCheckLabel.textColor = UIColor(named: "textColor")
        
        mainStackView.addArrangedSubview(passwordCheckLabel)
    }
    
    private func setupPasswordCheckTextField() {
        mainStackView.addArrangedSubview(passwordCheckTextField)
        
        passwordCheckTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        passwordCheckTextField.widthAnchor.constraint(equalToConstant: 326).isActive = true
        
        passwordCheckTextField.backgroundColor = UIColor(named: "textFieldColor")
        passwordCheckTextField.attributedPlaceholder = NSAttributedString(
            string: "შეიყვანეთ მომხმარებლის სახელი",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholder")]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        passwordCheckTextField.leftView = paddingView
        passwordCheckTextField.leftViewMode = .always
        passwordCheckTextField.font = UIFont.systemFont(ofSize: 12)
        passwordCheckTextField.layer.cornerRadius = 20
    }
    
    private func setupLogInButton() {
        logInButton.backgroundColor = UIColor(named: "loginButton")
        logInButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 327).isActive = true
        logInButton.setTitle("შესვლა", for: .normal)
        logInButton.layer.cornerRadius = 20
        logInButton.titleLabel?.font = .systemFont(ofSize: 12)
        
        let action = UIAction { [weak self] _ in
            guard let self,
                  let username = nameTextField.text, !username.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty,
                  let passwordCheck = passwordCheckTextField.text, !passwordCheck.isEmpty else {
                return
            }
            self.viewModel.loginButtonDidTap(username: username, password: password, passwordCheck: passwordCheck)
        }
        logInButton.addAction(action, for: .touchUpInside)
        mainStackView.addArrangedSubview(logInButton)
    }
}

// MARK: - AuthorizationViewModelDelegate
extension AuthorizationViewController: AuthorizationViewModelDelegate {
    func navigateToCountriesPage() {
        navigationController?.pushViewController(countriesListViewController, animated: false)
    }
}


