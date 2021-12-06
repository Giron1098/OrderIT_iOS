//
//  EditarPerfil_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 05/12/21.
//

import UIKit
import Alamofire

class EditarPerfil_ViewController: UIViewController {
    
    @IBOutlet weak var TF_Nombre_Editar: UITextField!
    @IBOutlet weak var TF_AP_Paterno_Editar: UITextField!
    
    @IBOutlet weak var TF_AP_Materno_Editar: UITextField!
    
    
    @IBOutlet weak var TF_Password_Anterior: UITextField!
    
    @IBOutlet weak var TF_New_Password: UITextField!
    
    var const = Constantes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let nombre_usuario = defaults.value(forKey: "nombre_usuario") as? String, let ap_paterno = defaults.value(forKey: "ap_paterno") as? String, let ap_materno = defaults.value(forKey: "ap_materno") as? String, let correo = defaults.value(forKey: "correo") as? String, let password = defaults.value(forKey: "password") as? String, let id_usuario = defaults.value(forKey: "id_usuario") as? Int
        {
            TF_Nombre_Editar.text = nombre_usuario
            TF_AP_Paterno_Editar.text = ap_paterno
            TF_AP_Materno_Editar.text = ap_materno

        }

    }
    
    @IBAction func BTN_A_Cancelar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BTN_A_Guardar(_ sender: UIButton) {
        //AQUI SE HARÁ LA PETICIÓN AL WS
        
        let defaults = UserDefaults.standard
        
        if let nombre_usuario_new = TF_Nombre_Editar.text, let ap_paterno_new = TF_AP_Paterno_Editar.text, let ap_materno_new = TF_AP_Materno_Editar.text, let password_old = TF_Password_Anterior.text, let password_new = TF_New_Password.text, let password_saved = defaults.value(forKey: "password") as? String, let correo = defaults.value(forKey: "correo") as? String, let id_usuario = defaults.value(forKey: "id_usuario") as? Int
        {
            if password_old == password_saved
            {
                if nombre_usuario_new != "" && ap_paterno_new != "" && ap_materno_new != "" && password_new != ""
                {
                    print("La contraseña ingresada es la misma, actualizando información")
                    
                    let URL_Update_Info = "http://\(const.dir_ip)/orderit/updateDatosUsuario.php?nombreUsuario=\(nombre_usuario_new)&apPaterno=\(ap_paterno_new)&apMaterno=\(ap_materno_new)&email=\(correo)&password=\(password_new)&idUsuario=\(id_usuario)"
                    
                    actualizarInformacion(URL: URL_Update_Info)
                } else {
                    showNoEmptyFieldsAlert()
                }
                
            } else {
                showPasswordErrorAlert()
            }
        }
    }
    
    func actualizarInformacion(URL:String)
    {
        print(URL)
            
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
                guard let data = responseData.data else { return }
                print(data)
            self.showCompletitionAlert()
        }
    }
    
    //Funcion para mostrar un alert en caso de que la información se actualice correctamente
    func showCompletitionAlert()
    {
        let alerta = UIAlertController(title: "Completado", message:"Datos del perfil actualizados correctamente\nVuelva a iniciar sesión por favor.", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default) { (_) in
            
            let defaults = UserDefaults.standard
            
            defaults.removeObject(forKey: "id_usuario")
            defaults.removeObject(forKey: "nombre_usuario")
            defaults.removeObject(forKey: "ap_paterno")
            defaults.removeObject(forKey: "ap_materno")
            defaults.removeObject(forKey: "correo")
            defaults.removeObject(forKey: "password")
            
            defaults.synchronize()
            
            self.TF_Nombre_Editar.text = ""
            self.TF_AP_Paterno_Editar.text = ""
            self.TF_AP_Materno_Editar.text = ""
            self.TF_Password_Anterior.text = ""
            self.TF_New_Password.text = ""
            
            self.navigationController?.popToRootViewController(animated: true)
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
    
    //Funcion para mostrar un alert en caso de que la contraseña actual no coincida
    func showPasswordErrorAlert()
    {
        let alerta = UIAlertController(title: "Hubo un problema", message:"La contrseña ingresada no coincide con tu contraseña actual", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
    
    
}
