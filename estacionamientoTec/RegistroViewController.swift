
import UIKit
import FirebaseAuth

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func alertaMsj(msj: String) {
        let alerta = UIAlertController(title: "Error", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
        
    }
    
    
    @IBAction func regButton(_ sender: UIButton) {
        if let email = correoTextField.text, let password = passTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error al crear el usuario\(e.localizedDescription)")
                    if e.localizedDescription == "The email address is badly formatted."{
                        self.alertaMsj(msj: "El formato del correo es incorrecto")
                    }else if e.localizedDescription == "The email address is already in use by another account."{
                        self.alertaMsj(msj: "Este correo ya esta en uso, favor de registrar otro")
                    }else if e.localizedDescription == "The password must be 6 characters long or more."{
                        self.alertaMsj(msj: "Lacontraseña debe tener 6 o mas cararcteres")
                    }
                    
                }else{
                    self.performSegue(withIdentifier: "regInicio", sender: self)
                }
            }
        }
        
    }
}

