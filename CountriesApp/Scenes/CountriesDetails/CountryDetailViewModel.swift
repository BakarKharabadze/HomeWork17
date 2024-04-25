//
//  CountryDetailViewModel.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/24/24.
//

import Foundation

protocol CountryDetailViewModelDelegate: AnyObject {
    func navigateToSafariViewController(with url: URL)
}

class CountryDetailViewModel {
    
    var info: Country
    weak var delegate: CountryDetailViewModelDelegate?
    
    init(info: Country) {
        self.info = info
    }
    func googleMapDidTap() {
        guard let googleMaps = info.maps?.googleMaps,
              let googleMap = URL(string: googleMaps) else {
            return
        }
        
        delegate?.navigateToSafariViewController(with: googleMap)
    }
    
    func mapDidTap() {
        guard let streetMaps = info.maps?.openStreetMaps,
              let map = URL(string: streetMaps) else  {
            return
        }
        
        delegate?.navigateToSafariViewController(with: map)
    }
}
