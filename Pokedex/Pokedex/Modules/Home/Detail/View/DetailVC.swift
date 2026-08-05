//
//  DetailVC.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    deinit{
        print("deinit-\(#function)")
    }
    // MARK: - Params
    
    // MARK: - Variables
    var coordinator: DetailCoord!
    var viewModel: DetailVM!
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewPokemon: UIView!
    @IBOutlet weak var btnFavs: UIButton!
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddFavs(_ sender: UIButton) {
        self.viewModel.selectToFav()
    }
    // MARK: - Funciones Inicio
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewPokemon.layer.cornerRadius = self.viewPokemon.frame.size.width / 2
        self.viewPokemon.layer.borderWidth = 1
        self.viewPokemon.layer.borderColor = UIColor.black.cgColor
        
        self.btnFavs.layer.cornerRadius = self.btnFavs.frame.size.width / 2
        
        self.setNeedsStatusBarAppearanceUpdate()
        self.tableView.register(UINib(nibName: Celdas.homeDetailTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Celdas.homeDetailTableViewCell.rawValue)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.delegate = self
        self.viewModel.initInfo()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRows(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRowAt(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectOption(tableView: tableView, indexPath: indexPath)
    }
}

// MARK: - Services Delegate
extension DetailVC: DetailProtocol {
    func refreshImage(link: String) {
        self.imageViewPokemon.load(link: link)
    }
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
    
    func refreshFav(exists: Bool) {
        if exists{
            self.btnFavs.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            self.btnFavs.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
}

