//
//  Registro_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 24/11/21.
//

import UIKit
import Alamofire

class Registro_ViewController: UIViewController {
    
    @IBOutlet weak var TF_Nombre_Registro: UITextField!
    @IBOutlet weak var TF_AP_Paterno_Registro: UITextField!
    
    @IBOutlet weak var TF_AP_Materno_Registro: UITextField!
    
    @IBOutlet weak var TF_Email_Registro: UITextField!
    @IBOutlet weak var TF_Password_Registro: UITextField!
    
    var const = Constantes()
    
    struct User: Codable{
        var idUsuario: Int?
        var nombreUsuario:String?
        var apPaterno:String?
        var apMaterno:String?
        var email:String?
        var password:String?
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BTN_A_Registrar_Usuario(_ sender: UIButton) {
        
        if let nombre_registro = TF_Nombre_Registro.text, let ap_paterno_registro = TF_AP_Paterno_Registro.text, let ap_materno_registro = TF_AP_Materno_Registro.text, let correo_registro = TF_Email_Registro.text, let password_registro = TF_Password_Registro.text
        {
            if nombre_registro != "" && ap_paterno_registro != "" && ap_materno_registro != "" && correo_registro != "" && password_registro != ""
            {
                let URL_New_User = "http://\(const.dir_ip)/orderit/registroUsuario.php?nombreUsuario=\(nombre_registro)&apPaterno=\(ap_paterno_registro)&apMaterno=\(ap_materno_registro)&email=\(correo_registro)&password=\(password_registro)"
                
                registrarUsuario(URL: URL_New_User)
                //print(nombre_registro,ap_paterno_registro,ap_paterno_registro,correo_registro,password_registro)
            } else {
                showNoEmptyFieldsAlert()
            }
        }
        
    }
    
    func registrarUsuario(URL:String)
    {
        print(URL)
            
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
                guard let data = responseData.data else { return }
                print(data)
        }
        
        self.showCompletitionRAlert()
    }
        
    //Funcion para mostrar un alert en caso de que el usuario se registre correctamente
    func showCompletitionRAlert()
    {
        let alerta = UIAlertController(title: "Completado", message:"Usuario registrado correctamente", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default) { (_) in
            
            self.TF_Nombre_Registro.text = ""
            self.TF_AP_Paterno_Registro.text = ""
            self.TF_AP_Materno_Registro.text = ""
            self.TF_Email_Registro.text = ""
            self.TF_Password_Registro.text = ""
            
            self.navigationController?.popViewController(animated: true)
            print("USUARIO REGISTRADO")
        }
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
    
    //Funcion para mostrar un alert en caso de que haya campos vacios
    func showNoEmptyFieldsAlert ()
    {
        let alerta = UIAlertController(title: "Hubo un problema", message:"No se permiten campos vacíos", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
    
    //OCULTAR TECLADO
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
