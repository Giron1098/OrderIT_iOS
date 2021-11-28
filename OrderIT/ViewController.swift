//
//  ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 24/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TF_Email_Login: UITextField!
    @IBOutlet weak var TF_Password_Login: UITextField!
    
    //Creamos un objeto de la clase Constantes para obtener la IP para usar los Web Services
    var const = Constantes()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func BTN_A_Login(_ sender: UIButton) {
        if let email = TF_Email_Login.text
        {
            if let password = TF_Password_Login.text
            {
                if email != "" && password != ""
                {
                    print("Email: \(email)")
                    print("Password: \(password)")
                    
                    print("Se manda la solicitud")
                    
                    
                }  else {
                    showNoEmptyFieldsAlert()
                }
            }
        }
    }
    

    //OCULTAR TECLADO
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Funcion para mostrar un alert en caso de que haya un campo vacío en el formulario del Login
    func showNoEmptyFieldsAlert ()
    {
        let alerta = UIAlertController(title: "Hubo un problema", message:"No se permiten campos vacíos", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
}

