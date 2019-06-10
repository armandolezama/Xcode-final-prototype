//
//  TableController.swift
//  Appministrator
//
//  Created by Laboratorio UNAM-Apple on 6/3/19.
//  Copyright © 2019 Laboratorio UNAM-Apple. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var nombresAlumnosArreglo:[String] = []
    
    var buscando: Bool = false
    
    var alumnoBuscado = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("En el table view")
        print(nombresAlumnosArreglo)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("En la funcion tableView")
        
        if buscando {
            return alumnoBuscado.count
        } else {
            return nombresAlumnosArreglo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if buscando {
            cell?.textLabel?.text = alumnoBuscado[indexPath.row]
        } else {
            cell?.textLabel?.text = nombresAlumnosArreglo[indexPath.row]
        }
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        alumnoBuscado = nombresAlumnosArreglo.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        buscando = true
        tbView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        buscando = false
        searchBar.text = ""
        tbView.reloadData()
    }

    
}




