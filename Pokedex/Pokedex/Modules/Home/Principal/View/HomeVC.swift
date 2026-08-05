//
//  HomeVC.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    // MARK: - Variables
    var coordinator: HomeCoord!
    var viewModel: HomeVM!
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBAction func goToFavoritos(_ sender: UIButton) {
        self.viewModel.goToFavotitos()
    }
    
    // MARK: - Funciones Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.tableView.register(UINib(nibName: Celdas.pokemonTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.pokemonTableViewCell.rawValue)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.delegate = self
        self.viewModel.initInfo()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectOption(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.willDisplay(tableView: tableView, indexPath: indexPath)
    }
}

// MARK: - Services Delegate
extension HomeVC: HomeProtocol {
    func refreshTableView() {
        self.tableView.reloadData()
    }
    
}

