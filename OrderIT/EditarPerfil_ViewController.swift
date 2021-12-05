//
//  EditarPerfil_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 05/12/21.
//

import UIKit

class EditarPerfil_ViewController: UIViewController {
    
    @IBOutlet weak var TF_Nombre_Editar: UITextField!
    @IBOutlet weak var TF_AP_Paterno_Editar: UITextField!
    
    @IBOutlet weak var TF_AP_Materno_Editar: UITextField!
    
    
    @IBOutlet weak var TF_Password_Anterior: UITextField!
    
    @IBOutlet weak var TF_New_Password: UITextField!
    
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
    }
    
    
}
