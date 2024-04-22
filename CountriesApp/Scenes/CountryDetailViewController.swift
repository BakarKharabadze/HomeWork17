//
//  CountryDetailViewController.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/21/24.
//

import UIKit
import SafariServices

class CountryDetailViewController: UIViewController {
    
    //MARK: Properties
    private let mainStackView = UIStackView()
    private let countryName = UILabel()
    private let countryFlagStackView = UIStackView()
    private var countryFlag = UIImageView()
    private let aboutTheFlagLabel = UILabel()
    private let flagDescriptionLabel = UILabel()
    private let seperatorView = UIView()
    private let seperatorStackView = UIStackView()
    private let basicInfoLabel = UILabel()
    private let nativeNameStackView = UIStackView()
    private let nativeNameLabel = UILabel()
    private let nativeNameAnswerLabel = UILabel()
    private let spellingStackView = UIStackView()
    private let spellingLabel = UILabel()
    private let spellingAnswerLabel = UILabel()
    private let capitalStackView = UIStackView()
    private let capitalLabel = UILabel()
    private let capitalAnswerLabel = UILabel()
    private let currencyStackView = UIStackView()
    private let currencyLabel = UILabel()
    private let currencyAnswerLabel = UILabel()
    private let regionStackView = UIStackView()
    private let regionLabel = UILabel()
    private let regionAnswerLabel = UILabel()
    private let neighborsStackView = UIStackView()
    private let neighborsLabel = UILabel()
    private let neighborsAnswerLabel = UILabel()
    private let bottomSeperatorStackView = UIStackView()
    private let bottomSeperator = UIView()
    private let linksLabel = UILabel()
    private let buttonsStackView = UIStackView()
    private let mapButton = UIButton()
    private let googleMapButton = UIButton()
    var info: Country?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        set()
    }
    
    func set() {
        countryName.text = info?.name.official
        guard let flag = info?.flags?.png,
              let flagUrl = URL(string: flag) else {
            return
        }
        countryFlag.load(url: flagUrl)
        flagDescriptionLabel.text = info?.flags?.alt
        nativeNameAnswerLabel.text = info?.name.common
        spellingAnswerLabel.text = info?.altSpellings?.first
        capitalAnswerLabel.text = info?.capital?.first
        currencyAnswerLabel.text = info?.currencies?.first?.key
        regionAnswerLabel.text = info?.region
        neighborsAnswerLabel.text = info?.borders?.joined(separator: ", ")
    }
    
    // MARK: Setup
    private func setup() {
        setupMainStackView()
        setupCountryName()
        setupCountryFlagStackView()
        setupCountryFlag()
        setupAboutTheFlagLabel()
        setupFlagDescriptionLabel()
        setupSeperatorStackView()
        setupSeperator()
        setupBasicInfo()
        setupNativeNameStackView()
        setupNativeNameLabel()
        setupNativeNameAnswerLabel()
        setupSpellingStackView()
        setupSpellingLabel()
        setupSpellingAnswerLabel()
        setupCapitalStackView()
        setupCapitalLabel()
        setupCapitalAnswerLabel()
        setupCurrencyStackView()
        setupCurrencyLabel()
        setupCurrencyAnswerLabel()
        setupRegionStackView()
        setupRegionLabel()
        setupRegionAnswerLabel()
        setupNeighborsStackView()
        setupNeighborsLabel()
        setupNeighborsAnswerLabel()
        setupBottomSeperatorStackView()
        setupBottomSeperator()
        setupLinksLabel()
        setupButtonsStackView()
        setupMapButton()
        setupGoogleMapButton()
        
        mainStackView.setCustomSpacing(30, after: countryName)
        mainStackView.setCustomSpacing(25, after: countryFlagStackView)
        mainStackView.setCustomSpacing(15, after: aboutTheFlagLabel)
        mainStackView.setCustomSpacing(24, after: seperatorStackView)
        mainStackView.setCustomSpacing(24, after: bottomSeperatorStackView)
    }
    
    // MARK: Setup UI Elements
    private func setupMainStackView() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        mainStackView.axis = .vertical
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(top: -60, left: 24, bottom: 0, right: 24)
    }
    
    private func setupCountryName() {
        countryName.textAlignment = .center
        countryName.font = .systemFont(ofSize: 17)
        
        mainStackView.addArrangedSubview(countryName)
    }
    
    private func setupCountryFlagStackView() {
        mainStackView.addArrangedSubview(countryFlagStackView)
        
        countryFlagStackView.isLayoutMarginsRelativeArrangement = true
        countryFlagStackView.layoutMargins = UIEdgeInsets(top: -20, left: -10, bottom: 0, right: -10)
    }
    
    private func setupCountryFlag() {
        countryFlagStackView.addArrangedSubview(countryFlag)
        
        countryFlag.heightAnchor.constraint(equalToConstant: 228).isActive = true
        countryFlag.widthAnchor.constraint(equalToConstant: 343).isActive = true
        countryFlag.layer.cornerRadius = 20
        countryFlag.layer.shadowColor = UIColor.black.cgColor
        countryFlag.layer.shadowRadius = 3.0
        countryFlag.layer.shadowOpacity = 1.0
        countryFlag.layer.shadowOffset = CGSize(width: 4, height: 4)
        countryFlag.layer.masksToBounds = false
    }
    
    private func setupAboutTheFlagLabel() {
        aboutTheFlagLabel.text = "About the flag"
        aboutTheFlagLabel.textColor = .black
        aboutTheFlagLabel.font = .systemFont(ofSize: 16)
        
        mainStackView.addArrangedSubview(aboutTheFlagLabel)
    }
    
    private func setupFlagDescriptionLabel() {
        flagDescriptionLabel.textColor = .black
        flagDescriptionLabel.font = .systemFont(ofSize: 14)
        flagDescriptionLabel.numberOfLines = 0
        
        mainStackView.addArrangedSubview(flagDescriptionLabel)
    }
    
    private func setupSeperator() {
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView.backgroundColor = .gray
        
        seperatorStackView.addArrangedSubview(seperatorView)
    }
    
    private func setupSeperatorStackView() {
        mainStackView.addArrangedSubview(seperatorStackView)
        
        seperatorStackView.isLayoutMarginsRelativeArrangement = true
        seperatorStackView.layoutMargins = UIEdgeInsets(top: 20, left: 28, bottom: 0, right: 28)
    }
    
    private func setupBasicInfo() {
        basicInfoLabel.text = "Basic information:"
        basicInfoLabel.font = .systemFont(ofSize: 16)
        
        mainStackView.addArrangedSubview(basicInfoLabel)
    }
    
    private func setupNativeNameStackView() {
        mainStackView.addArrangedSubview(nativeNameStackView)
        
        nativeNameStackView.distribution = .equalSpacing
        nativeNameStackView.isLayoutMarginsRelativeArrangement = true
        nativeNameStackView.layoutMargins.top = 15
    }
    
    private func setupNativeNameLabel() {
        nativeNameLabel.text = "Native name:"
        nativeNameLabel.font = .systemFont(ofSize: 14)
        
        nativeNameStackView.addArrangedSubview(nativeNameLabel)
    }
    
    private func setupNativeNameAnswerLabel() {
        nativeNameAnswerLabel.font = .systemFont(ofSize: 14)
        
        nativeNameStackView.addArrangedSubview(nativeNameAnswerLabel)
    }
    
    private func setupSpellingStackView() {
        mainStackView.addArrangedSubview(spellingStackView)
        
        spellingStackView.distribution = .equalSpacing
        spellingStackView.isLayoutMarginsRelativeArrangement = true
        spellingStackView.layoutMargins.top = 15
    }
    
    private func setupSpellingLabel() {
        spellingLabel.text = "Spelling:"
        spellingLabel.font = .systemFont(ofSize: 14)
        
        spellingStackView.addArrangedSubview(spellingLabel)
    }
    
    private func setupSpellingAnswerLabel() {
        spellingAnswerLabel.font = .systemFont(ofSize: 14)
        
        spellingStackView.addArrangedSubview(spellingAnswerLabel)
    }
    
    private func setupCapitalStackView() {
        mainStackView.addArrangedSubview(capitalStackView)
        
        capitalStackView.distribution = .equalSpacing
        capitalStackView.isLayoutMarginsRelativeArrangement = true
        capitalStackView.layoutMargins.top = 15
    }
    
    private func setupCapitalLabel() {
        capitalLabel.text = "Capital:"
        capitalLabel.font = .systemFont(ofSize: 14)
        
        capitalStackView.addArrangedSubview(capitalLabel)
    }
    
    private func setupCapitalAnswerLabel() {
        capitalAnswerLabel.font = .systemFont(ofSize: 14)
        
        capitalStackView.addArrangedSubview(capitalAnswerLabel)
    }
    
    private func setupCurrencyStackView() {
        mainStackView.addArrangedSubview(currencyStackView)
        
        currencyStackView.distribution = .equalSpacing
        currencyStackView.isLayoutMarginsRelativeArrangement = true
        currencyStackView.layoutMargins.top = 15
    }
    
    private func setupCurrencyLabel() {
        currencyLabel.text = "Currency:"
        currencyLabel.font = .systemFont(ofSize: 14)
        
        currencyStackView.addArrangedSubview(currencyLabel)
    }
    
    private func setupCurrencyAnswerLabel() {
        currencyAnswerLabel.font = .systemFont(ofSize: 14)
        
        currencyStackView.addArrangedSubview(currencyAnswerLabel)
    }
    
    private func setupRegionStackView() {
        mainStackView.addArrangedSubview(regionStackView)
        
        regionStackView.distribution = .equalSpacing
        regionStackView.isLayoutMarginsRelativeArrangement = true
        regionStackView.layoutMargins.top = 15
        
    }
    
    private func setupRegionLabel() {
        regionLabel.text = "Region:"
        regionLabel.font = .systemFont(ofSize: 14)
        
        regionStackView.addArrangedSubview(regionLabel)
    }
    
    private func setupRegionAnswerLabel() {
        regionAnswerLabel.font = .systemFont(ofSize: 14)
        
        regionStackView.addArrangedSubview(regionAnswerLabel)
    }
    
    private func setupNeighborsStackView() {
        mainStackView.addArrangedSubview(neighborsStackView)
        
        neighborsStackView.distribution = .equalSpacing
        neighborsStackView.isLayoutMarginsRelativeArrangement = true
        neighborsStackView.layoutMargins.top = 15
    }
    
    private func setupNeighborsLabel() {
        neighborsLabel.text = "Neighbors:"
        neighborsLabel.font = .systemFont(ofSize: 14)
        
        neighborsStackView.addArrangedSubview(neighborsLabel)
    }
    
    private func setupNeighborsAnswerLabel() {
        neighborsAnswerLabel.font = .systemFont(ofSize: 14)
        
        neighborsStackView.addArrangedSubview(neighborsAnswerLabel)
    }
    
    private func setupBottomSeperatorStackView() {
        mainStackView.addArrangedSubview(bottomSeperatorStackView)
        
        bottomSeperatorStackView.isLayoutMarginsRelativeArrangement = true
        bottomSeperatorStackView.layoutMargins = UIEdgeInsets(top: 20, left: 28, bottom: 0, right: 28)
    }
    
    private func setupBottomSeperator() {
        bottomSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomSeperator.backgroundColor = .gray
        
        bottomSeperatorStackView.addArrangedSubview(bottomSeperator)
    }
    
    private func setupLinksLabel() {
        linksLabel.text = "Useful links:"
        linksLabel.font = .systemFont(ofSize: 16)
        
        mainStackView.addArrangedSubview(linksLabel)
    }
    
    private func setupButtonsStackView() {
        mainStackView.addArrangedSubview(buttonsStackView)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.isLayoutMarginsRelativeArrangement = true
        buttonsStackView.layoutMargins.top = 15
        buttonsStackView.spacing = 20
        buttonsStackView.distribution = .fillEqually
    }
    
    private func setupMapButton() {
        buttonsStackView.addArrangedSubview(mapButton)
        
        mapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mapButton.backgroundColor = .clear
        mapButton.layer.cornerRadius = 10
        let image = UIImage(named: "Map")
        mapButton.setImage(image, for: .normal)
        let action = UIAction { action in
            self.mapDidTap()
        }
        mapButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupGoogleMapButton() {
        buttonsStackView.addArrangedSubview(googleMapButton)
        
        googleMapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        googleMapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        googleMapButton.backgroundColor = .clear
        googleMapButton.layer.cornerRadius = 10
        let image = UIImage(named: "googleMap")
        googleMapButton.setImage(image, for: .normal)
        let action = UIAction { action in
            self.googleMapDidTap()
        }
        googleMapButton.addAction(action, for: .touchUpInside)
    }
    
    private func mapDidTap() {
        guard let streetMaps = info?.maps?.openStreetMaps,
              let map = URL(string: streetMaps) else  {
            return
        }
        
        let safariVC = SFSafariViewController(url: map)
        present(safariVC, animated: true, completion: nil)
    }
    
    private func googleMapDidTap() {
        guard let googleMaps = info?.maps?.googleMaps,
              let googleMap = URL(string: googleMaps) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: googleMap)
        present(safariVC, animated: true, completion: nil)
    }
}
