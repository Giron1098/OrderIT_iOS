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
    
    struct Mensaje: Codable{
        var mensaje:String?
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
                //print(nombre_registro,ap_paterno_registro,ap_paterno_registro,correo_registro,password_registro)
                
                print(URL_New_User)
                    
                AF.request(URL_New_User, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
                        guard let data = responseData.data else { return }
                        do
                        {
                            let mensaje = try JSONDecoder().decode(Mensaje.self, from: data)
                            
                            if let mensaje = mensaje.mensaje
                            {
                                if mensaje == "Correo ya registrado"
                                {
                                    self.showEmailErrorAlert(mensaje: mensaje)
                                } else if mensaje == "Usuario registrado exitosamente"
                                {
                                    self.showCompletitionRAlert(mensaje: mensaje)
                                }
                            }
                        } catch {
                            print("Error decoding: \(error)")
                        }
                }
                
            } else {
                showNoEmptyFieldsAlert()
            }
        }
        
    }
    
    //Funcion para mostrar un alert en caso de que el usuario se registre correctamente
    func showCompletitionRAlert(mensaje:String)
    {
        let alerta = UIAlertController(title: "Completado", message:mensaje, preferredStyle: .alert)
        
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
    
    //Funcion para mostrar un alert en caso de que el correo ya esté registrado
    func showEmailErrorAlert(mensaje:String)
    {
        let alerta = UIAlertController(title: "Hubo un problema", message:mensaje, preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
    
    //OCULTAR TECLADO
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
