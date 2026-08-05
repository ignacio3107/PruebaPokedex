//
//  FavoritosVC.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 04/08/26.
//

import UIKit

class FavoritosVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var datos: [String] = ["Element1", "Element2"]
    private let identificadorCelda = "CelfaFavs"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        self.configurarTable()
        
        if let favs = UserDefaults.standard.stringArray(forKey: "Favoritos"){
            self.datos.removeAll()
            self.datos = favs
            print(":::::::FAVORITOS ::::::")
            print(favs)
            self.tableView.reloadData()
        }else {
            print("No hay datos guardados...")
            self.datos.removeAll()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configurarTable(){
        self.tableView.frame = view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.tableView)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identificadorCelda)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificadorCelda, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = datos[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
}
