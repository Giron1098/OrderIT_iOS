//
//  ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 24/11/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var TF_Email_Login: UITextField!
    @IBOutlet weak var TF_Password_Login: UITextField!
    
    struct User: Codable{
        var idUsuario: Int?
        var nombreUsuario:String?
        var apPaterno:String?
        var apMaterno:String?
        var email:String?
        var password:String?
    }
    
    //Creamos un objeto de la clase Constantes para obtener la IP para usar los Web Services
    var const = Constantes()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Recuperamos las credenciales guardadas previamente en caso de que un usuario se haya logueado correctamente
        let defaults = UserDefaults.standard

        if let nombre_usuario = defaults.value(forKey: "nombre_usuario") as? String, let ap_paterno = defaults.value(forKey: "ap_paterno") as? String, let ap_materno = defaults.value(forKey: "ap_materno") as? String, let correo = defaults.value(forKey: "correo") as? String, let password = defaults.value(forKey: "password") as? String, let id_usuario = defaults.value(forKey: "id_usuario") as? Int
        {
            performSegue(withIdentifier: "userValidated", sender: self)
        }
       
    }
    
    @IBAction func BTN_A_Login(_ sender: UIButton) {
        if let email = TF_Email_Login.text
        {
            if let password = TF_Password_Login.text
            {
                if email != "" && password != ""
                {
                    //print("Email: \(email)")
                    //print("Password: \(password)")
                    
                    //Creamos un arreglo con los parametros para la petición GET para validar al usuario
                    let parameters: Parameters=[
                        "email":email,
                        "password":password
                    ]
                    
                    //Creamos la URL donde esta ubicado el Web Service a usar
                    
                    let URL_USER_VALIDATION = "http://\(const.dir_ip)/orderit/validarUsuario.php"
                    
                    //Mandamos la petición GET
                    AF.request(URL_USER_VALIDATION, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
                        guard let data = responseData.data else { return }
                        
                        do
                        {
                            let usuario = try JSONDecoder().decode(User.self, from: data)
                            
                            if let idUsuario = usuario.idUsuario
                            {
                                if let nombreUsuario = usuario.nombreUsuario
                                {
                                    if let apPaterno = usuario.apPaterno
                                    {
                                        if let apMaterno = usuario.apMaterno
                                        {
                                            if let email = usuario.email
                                            {
                                                if let password = usuario.password
                                                {
                                                    /*print(idUsuario)
                                                    print(nombreUsuario)
                                                    print(apPaterno)
                                                    print(apMaterno)
                                                    print(email)
                                                    print(password)*/
                                                    
                                                    print("LOGIN EXITOSO")
                                                    
                                                    //Guardamos la sesión
                                                    let defaults = UserDefaults.standard
                                                    
                                                    defaults.set(idUsuario,forKey: "id_usuario")
                                                    
                                                    defaults.set(nombreUsuario,forKey: "nombre_usuario")
                                                    defaults.set(apPaterno,forKey: "ap_paterno")
                                                    defaults.set(apMaterno,forKey: "ap_materno")

                                                    defaults.set(email,forKey: "correo")
                                                    defaults.set(password, forKey: "password")
                                                    defaults.synchronize()
                                                    
                                                    self.TF_Email_Login.text = ""
                                                    self.TF_Password_Login.text = ""
                                                    
                                                    self.performSegue(withIdentifier: "userValidated", sender: nil)
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                self.showCredentialsErrorAlert()
                            }
                        } catch {
                            print("Error decoding \(error)")
                        }
                    }
                    

                    
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
    func showCredentialsErrorAlert ()
    {
        let alerta = UIAlertController(title: "Hubo un problema", message:"Usuario no encontrado o credenciales no validas", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
    
    //Funcion para mostrar un alert en caso de que las credenciales no sean validas o no exista el usuario
    func showNoEmptyFieldsAlert ()
    {
        let alerta = UIAlertController(title: "Hubo un problema", message:"No se permiten campos vacíos", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
}

