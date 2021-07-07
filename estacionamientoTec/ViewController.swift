//
//  ViewController.swift
//  estacionamientoTec
//
//  Created by Mac19 on 04/07/21.
//

import UIKit
import CLTypingLabel
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var msjBienvenidoLabel: CLTypingLabel!
    
    @IBOutlet weak var correoLTF: UITextField!
    @IBOutlet weak var passLTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msjBienvenidoLabel.charInterval = 0.1
        
        msjBienvenidoLabel.text = "Bienvenido Inicia Sesion"
        
        
    }
    
    func alertaMsj(msj: String) {
        let alerta = UIAlertController(title: "Error", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
        
    }

    @IBAction func loginS(_ sender: UIButton) {
        if let email = correoLTF.text, let password = passLTF.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let e = error{
                    print(e.localizedDescription)
                    if e.localizedDescription == "The password is invalid or the user does not have a password."{
                        self.alertaMsj(msj: "Contraseña incorrecta")
                    }else if e.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted."{
                        self.alertaMsj(msj: "Este correo no esta registrado")
                    }else if e.localizedDescription == "The email address is badly formatted."{
                        self.alertaMsj(msj: "Formato de correo erroneo")
                    }
                }else{
                    self.performSegue(withIdentifier: "inicio", sender: self)
                }
            }
        }
        }
        
    
}

