//
//  CountriesCellsTableViewCell.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/21/24.
//

import UIKit

class CountriesCellsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    private let mainStackView = UIStackView()
    private let trailingStackView = UIStackView()
    private let flag = UILabel()
    private let countryNameLabel = UILabel()
    private let separatorView = UIView()
    private let arrowImageView = UIImageView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        setupSeparatorView()
        setupMainStackView()
        setupFlag()
        setupTrailingStackView()
        setupCountryLabel()
        setupArrowImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        mainStackView.layer.borderColor = UIColor(named: "borderColor")?.resolvedColor(with: self.traitCollection).cgColor
    }
    
    //MARK: Setup Methods
    private func setupMainStackView() {
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .equalSpacing
        mainStackView.layer.cornerRadius = 20
        mainStackView.layer.borderWidth = 1.5
        mainStackView.layer.borderColor = UIColor(named: "borderColor")?.resolvedColor(with: self.traitCollection).cgColor
        mainStackView.backgroundColor = UIColor(named: "cellColor")
        
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(top: 15, left: 24, bottom: 15, right: 0)
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.separatorView.topAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27).isActive = true
    }
    
    private func setupFlag() {
        flag.font = .systemFont(ofSize: 30)
        mainStackView.addArrangedSubview(flag)
    }
    
    private func setupTrailingStackView() {
        trailingStackView.addArrangedSubview(countryNameLabel)
        trailingStackView.addArrangedSubview(arrowImageView)
        trailingStackView.spacing = 8
        
        mainStackView.addArrangedSubview(trailingStackView)
        trailingStackView.isLayoutMarginsRelativeArrangement = true
        trailingStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 23)
    }
    
    private func setupCountryLabel() {
        countryNameLabel.font = UIFont.systemFont(ofSize: 14)
        countryNameLabel.textColor = UIColor(named: "textColor")
    }
    
    private func setupArrowImageView() {
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .gray
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func setupSeparatorView() {
        addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func configure(with country: Country) {
        countryNameLabel.text = country.name.common
        flag.text = country.flag
    }
}
