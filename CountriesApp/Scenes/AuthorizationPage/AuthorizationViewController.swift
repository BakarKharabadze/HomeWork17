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
    private let errorLabel = UILabel()
    private let logInButton = UIButton()
    var countriesListViewController = CountriesListViewController()
    var viewModel = AuthorizationViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.delegate = self
        viewModel.viewDidLoad()
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
        setupErrorLabel()
        
        mainStackView.setCustomSpacing(6, after: nameLabel)
        mainStackView.setCustomSpacing(30, after: nameTextField)
        mainStackView.setCustomSpacing(6, after: passwordLabel)
        mainStackView.setCustomSpacing(30, after: passwordTextField)
        mainStackView.setCustomSpacing(6, after: passwordCheckLabel)
        mainStackView.setCustomSpacing(50, after: passwordCheckTextField)
        mainStackView.setCustomSpacing(8, after: logInButton)
    }
    
    private func setupImageButtonStackView() {
        view.addSubview(imageButtonStackView)
        
        imageButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        imageButtonStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        imageButtonStackView.isLayoutMarginsRelativeArrangement = true
        imageButtonStackView.layoutMargins = UIEdgeInsets(top: -30, left: 120, bottom: 0, right: 120)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageButton.setImage(selectedImage, for: .normal)
            viewModel.saveImageToDocuments(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        let action = UIAction { [weak self] _ in
            self?.viewModel.imageButtonTapped()
        }
        imageButton.addAction(action, for: .touchUpInside)
        
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
        passwordTextField.isSecureTextEntry = true
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
        passwordCheckTextField.isSecureTextEntry = true
    }
    
    private func setupErrorLabel() {
        mainStackView.addArrangedSubview(errorLabel)
        
        errorLabel.textAlignment = .center
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.isHidden = true
    }
    
    private func setupLogInButton() {
        logInButton.backgroundColor = UIColor(named: "loginButton")
        logInButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 327).isActive = true
        logInButton.setTitle("შესვლა", for: .normal)
        logInButton.layer.cornerRadius = 20
        logInButton.titleLabel?.font = .systemFont(ofSize: 12)
        
        let action = UIAction { [weak self] _ in
            self?.viewModel.loginButtonDidTap(username: self?.nameTextField.text, password: self?.passwordTextField.text, passwordCheck: self?.passwordCheckTextField.text)
        }
        logInButton.addAction(action, for: .touchUpInside)
        mainStackView.addArrangedSubview(logInButton)
    }
}

// MARK: - AuthorizationViewModelDelegate
extension AuthorizationViewController: AuthorizationViewModelDelegate {
    func showError(with error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
    }
    
    func navigateToImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imageLoaded(_ image: UIImage) {
        imageButton.setImage(image, for: .normal)
    }
    
    func navigateToCountriesPage() {
        navigationController?.pushViewController(countriesListViewController, animated: false)
    }
}


