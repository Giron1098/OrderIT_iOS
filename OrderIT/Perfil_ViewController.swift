//
//  Perfil_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 02/12/21.
//

import UIKit

class Perfil_ViewController: UIViewController {

    @IBOutlet weak var TF_Nombre_Perfil: UITextField!
    @IBOutlet weak var TF_AP_Paterno_Perfil: UITextField!
    
    @IBOutlet weak var TF_AP_Materno_Perfil: UITextField!
    
    @IBOutlet weak var TF_Email_Usuario: UITextField!
    
    @IBOutlet weak var TF_Password_Perfil: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        let defaults = UserDefaults.standard
        
        if let nombre_usuario = defaults.value(forKey: "nombre_usuario") as? String, let ap_paterno = defaults.value(forKey: "ap_paterno") as? String, let ap_materno = defaults.value(forKey: "ap_materno") as? String, let correo = defaults.value(forKey: "correo") as? String, let password = defaults.value(forKey: "password") as? String, let id_usuario = defaults.value(forKey: "id_usuario") as? Int
        {
            TF_Nombre_Perfil.text = nombre_usuario
            TF_AP_Paterno_Perfil.text = ap_paterno
            TF_AP_Materno_Perfil.text = ap_materno
            TF_Email_Usuario.text = correo
            TF_Password_Perfil.text = password
        }
    }
    
    @IBAction func BTN_A_Cerrar_Sesion(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "id_usuario")
        defaults.removeObject(forKey: "nombre_usuario")
        defaults.removeObject(forKey: "ap_paterno")
        defaults.removeObject(forKey: "ap_materno")
        defaults.removeObject(forKey: "correo")
        defaults.removeObject(forKey: "password")
        
        defaults.synchronize()
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    
    
}
