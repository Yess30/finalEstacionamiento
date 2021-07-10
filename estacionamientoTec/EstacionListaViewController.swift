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
    
    var editarE: String!

    @IBOutlet weak var tablaEspacios: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        tablaEspacios.register(UINib(nibName: "espaciosTableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
        cargarEspaciosL()
    }
    
    func cargarEspaciosL() {
        db.collection("Espacios").order(by: "nombre").addSnapshotListener() { (querySnapshot, err) in
            //vaciar arreglo
          
            if let e = err {
                print("Error al cargar los espacios: \(e.localizedDescription)")
            } else {
                if let snapshotDocumentos = querySnapshot?.documents{
                    self.lugares = []
                    for document in snapshotDocumentos {
                        //Crear objeto espacio
                        
                        let datos = document.data()
                        print(datos)
                        //self.lugares = []
                        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaEspacios.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! espaciosTableViewCell
        celda.espacioLabel?.text = lugares[indexPath.row].nombre
        if lugares[indexPath.row].estado == "1" {
            celda.estadoLabel?.text = "Libre"
            celda.botonAc.backgroundColor = UIColor.green
        }else{
            celda.estadoLabel?.text = "ocupado"
            celda.botonAc.backgroundColor = UIColor.red
        }
        //celda.estadoE = lugares[indexPath.row].estado
        //celda.estadoLabel?.text = lugares[indexPath.row].estado
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celda = tablaEspacios.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! espaciosTableViewCell
        let nom = lugares[indexPath.row].nombre
        
        
        if lugares[indexPath.row].estado == "1" {
            db.collection("Espacios").document(nom).setData([
                "estado": "0",
                "nombre": nom
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    celda.botonAc.backgroundColor = UIColor.red
                    celda.estadoLabel?.text = "Ocupado"
                    self.cargarEspaciosL()
                    self.tablaEspacios.reloadData()
                    
                }
            }
           
        }else{
            db.collection("Espacios").document(nom).setData([
                "estado": "1",
                "nombre": nom
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    celda.botonAc.backgroundColor = UIColor.green
                    celda.estadoLabel?.text = "Libre"
                    self.cargarEspaciosL()
                    self.tablaEspacios.reloadData()
                }
            }
            
        }
        
        
    }
    
    
}	
