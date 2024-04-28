//
//  CountriesListViewModel.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/24/24.
//
import UIKit
import Foundation

protocol CountriesListViewModelDelegate: AnyObject {
    func updateUI()
    func navigateToCountryDetail(with model: Country)
    func showWelcomeAlert()
}

class CountriesListViewModel {
    var info = [Country]()
    
    private(set) var filteredInfo: [Country] = []
    var searchMode = false
        
    weak var delegate: CountriesListViewModelDelegate?
    
    func viewDidLoad() {
        fetchData()
    }
    
    func viewDidAppear() {
        if UserDefaults.standard.bool(forKey: "isFirstLogin") {
            delegate?.showWelcomeAlert()
                UserDefaults.standard.set(false, forKey: "isFirstLogin")
            }
    }
    
    private func sortCountriesByName() {
        info.sort { $0.name.common ?? "" < $1.name.common ?? "" }
    }
    
    func fetchData() {
        let url = "https://restcountries.com/v3.1/all"
        getData(from: url) { [weak self] result in
            switch result {
            case .success(let info):
                self?.info = info
                self?.sortCountriesByName()
                self?.delegate?.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectRowAt(_ index: Int) {
        delegate?.navigateToCountryDetail(with: searchMode ? filteredInfo[index] : info[index])
    }
    
    private func getData(from url: String, completion: @escaping (Result<[Country], Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
            var result: [Country]?
            do {
                result = try JSONDecoder().decode([Country].self, from: data)
            }
            catch {
                completion(.failure(error))
            }
            
            if let result {
                completion(.success(result))
            }
        })
        .resume()
    }
}

extension CountriesListViewModel {
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        searchMode = isActive && !searchText.isEmpty
        return searchMode
    }
    
    public func updateSearchController(searchBarText: String?) {
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
                self.filteredInfo = self.info.filter { country in
                    let nameContainsSearchText = country.name.common?.lowercased().contains(searchText) ?? false
                    let spellingContainsSearchText = country.altSpellings?.first?.lowercased().contains(searchText) ?? false
                    return nameContainsSearchText || spellingContainsSearchText
                }
            } else {
                self.filteredInfo = self.info
            }
        delegate?.updateUI()
    }
}
