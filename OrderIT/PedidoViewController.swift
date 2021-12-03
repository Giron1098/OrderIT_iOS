//
//  PedidoViewController.swift
//  OrderIT
//
//  Created by Mac4 on 02/12/21.
//

import UIKit
import Alamofire

class PedidoViewController: UIViewController {
    
    var idRestaurante_recibido: Int?
    var nombreRest_recibido:String?
    var direccion_recibido:String?
    var horario_recibido:String?
    var tiempoEstimado_recibido:String?
    var costoEntrega_recibido:Int?
    var idPlatillos_recibido:Int?
    var nombrePlatillo_recibido:String?
    var precio_recibido:Double?

    @IBOutlet weak var LBL_NombreRestaurante: UILabel!
    
    @IBOutlet weak var LBL_NombrePlatillo: UILabel!
    @IBOutlet weak var LBL_CostoPlatillo: UILabel!
    
    
    @IBOutlet weak var LBL_Cantidad: UILabel!

    @IBOutlet weak var LBL_CostoEntrega: UILabel!
    
    @IBOutlet weak var LBL_Total: UILabel!
    
    var cantidadPedido:Double?
    var total:Double = 0.0
    
    var const = Constantes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LBL_NombreRestaurante.text = nombreRest_recibido
        
        //print(nombrePlatillo_recibido)
        LBL_NombrePlatillo.text = nombrePlatillo_recibido
        LBL_CostoPlatillo.text = "\(precio_recibido!)"
        
        LBL_CostoEntrega.text = "\(costoEntrega_recibido!)"
        
    }
    
    @IBAction func STPR_Cantidad(_ sender: UIStepper) {
        let cantidad:Int = Int(sender.value)
        
        cantidadPedido = Double(sender.value)
        LBL_Cantidad.text = "\(cantidad.description)"
        
        if let cantidad = cantidadPedido, let precio = precio_recibido, let costoEnvio = costoEntrega_recibido
        {
            
            /*print("Cantidad: $\(cantidad)")
            print("Precio: $\(precio)")
            print("Costo envio: $ \(Double(costoEnvio))")*/
            
            total = (cantidad * precio) + Double(costoEnvio)
            
            //print("Total: $\(total)")
            if total == Double(costoEnvio)
            {
                LBL_Total.text = "0"
            } else {
                LBL_Total.text = "\(total)"
            }
        }
    }
    
    @IBAction func BTN_HacerPedido(_ sender: UIButton) {
        let date = Date()
        
        let dateF = DateFormatter()
        
        dateF.locale = Locale(identifier: "es_MX")
        dateF.dateStyle = .short
        
        let fecha = dateF.string(from: date)
        print("DATOS PARA EL INSERT")
        
        let defaults = UserDefaults.standard
        
        if let cantidad = cantidadPedido, let id_platillo = idPlatillos_recibido, let id_usuario = defaults.value(forKey: "id_usuario") as? Int, let costoEnvio = costoEntrega_recibido
        {
            if total != Double(costoEnvio)
            {
                /*print("Fecha: \(fecha)")
                print("Cantidad: \(cantidad)")
                print("Total: \(total)")
                print("ID Platillo: \(id_platillo)")
                print("ID Usuario: \(id_usuario)")*/
                
                let URL_Registro_Pedido = "http://\(const.dir_ip)/orderit/registroPedido.php?fecha=\(fecha)&cantidad=\(cantidad)&total=\(total)&Platillos_idPlatillos=\(id_platillo)&Usuario_idUsuario=\(id_usuario)"
                                
                registrarPedido(URL: URL_Registro_Pedido)
            }
        }
    }
    
    func registrarPedido(URL:String)
    {
        //print(URL)
            
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
                guard let data = responseData.data else { return }
                print(data)
            self.showCompletitionAlert()
        }
    }
    
    //Funcion para mostrar un alert en caso de que el pedido se haya realizado correctamente
    func showCompletitionAlert ()
    {
        let alerta = UIAlertController(title: "Completado", message:"Pedido realizado correctamente", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
}
