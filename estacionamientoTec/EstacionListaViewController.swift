//
//  EstacionListaViewController.swift
//  estacionamientoTec
//
//  Created by Mac19 on 04/07/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class EstacionListaViewController: UIViewController {
    
    var lugares = [Espacio]()
    let db = Firestore.firestore()

    @IBOutlet weak var tablaEspacios: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        cargarEspaciosL()
    }
    
    func cargarEspaciosL() {
        db.collection("Espacios").order(by: "nombre").addSnapshotListener() { (querySnapshot, err) in
            //vaciar arreglo
          
            if let e = err {
                print("Error al cargar los espacios: \(e.localizedDescription)")
            } else {
                if let snapshotDocumentos = querySnapshot?.documents{
                    for document in snapshotDocumentos {
                        //Crear objeto espacio
                        let datos = document.data()
                        print(datos)
                        
                        //Sacar parametros
                        guard let nombreD = datos["nombre"] as? String else { return }
                        guard let estadoD = datos["estado"] as? String else { return }
                      //  guard let colorD = datos["color"] as? String else { return }
                        
                        //let nuevoEsp = Espacio.init(nombre: nombreD, estado: estadoD)
                        let espacio = Espacio(nombre: nombreD, estado: estadoD)
                        self.lugares.append(espacio)
                        
                        
                        
                        
                        
                    }
                    // linea necesaria para hacer que la tabla se refresque con los nuevos datos
                    self.tablaEspacios.reloadData()
                    
                    
                }
                
            }
        }
    }
    

    

}


extension EstacionListaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lugares.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaEspacios.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = lugares[indexPath.row].nombre
        celda.detailTextLabel?.text = lugares[indexPath.row].estado
        
        return celda
    }
    
    
}	
