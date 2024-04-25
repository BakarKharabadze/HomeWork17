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
    private let viewModel = CountriesListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupTableView()
        setupNavigationController()
        self.setupSearchController()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        setupTopBarText()
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
        tableView.backgroundColor = .clear
    }
    
    private func setupNavigationController() {
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTopBarText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension CountriesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}

// MARK: - UITableViewDataSource
extension CountriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.info.count
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredInfo.count : self.viewModel.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCellsTableViewCell" , for: indexPath) as! CountriesCellsTableViewCell
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let infoItem = inSearchMode ? self.viewModel.filteredInfo[indexPath.row] : self.viewModel.info[indexPath.row]

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
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let infoItem = inSearchMode ? self.viewModel.filteredInfo[indexPath.row] : self.viewModel.info[indexPath.row]
        viewModel.didSelectRowAt(indexPath.row)
    }
}
// MARK: - CountriesListViewModelDelegate
extension CountriesListViewController: CountriesListViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func navigateToCountryDetail(with model: Country) {
        let vc = CountryDetailViewController()
        vc.viewModel = CountryDetailViewModel(info: model)
        navigationController?.pushViewController(vc, animated: false)
    }
}
