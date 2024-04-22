//
//  CountriesListViewController.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/21/24.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    //MARK: Properties
    private let tableView = UITableView()
    private var info = [Country]()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
        fetchData()
    }
    
    //MARK: Setup
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountriesCellsTableViewCell.self, forCellReuseIdentifier: "CountriesCellsTableViewCell")
    }
    
    private func setupNavigationController() {
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func sortCountriesByName() {
        info.sort { $0.name.common ?? "" < $1.name.common ?? "" }
        //tableView.reloadData()
    }
    
    //MARK: Data Fetching
    private func fetchData() {
        let url = "https://restcountries.com/v3.1/all"
        getData(from: url) { [weak self] result in
            switch result {
            case .success(let info):
                self?.info = info
                self?.sortCountriesByName()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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

// MARK: - UITableViewDataSource
extension CountriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCellsTableViewCell" , for: indexPath) as! CountriesCellsTableViewCell
        let infoItem = info[indexPath.row]
        cell.configure(with: infoItem)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CountriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailViewController()
        vc.info = info[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
    }
}
