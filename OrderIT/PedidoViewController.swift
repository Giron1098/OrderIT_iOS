//
//  PedidoViewController.swift
//  OrderIT
//
//  Created by Mac4 on 02/12/21.
//

import UIKit

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
        LBL_Cantidad.text = "\(cantidad)"
    }
    
    @IBAction func BTN_CalcularTotal(_ sender: UIButton) {

        if let cantidad = cantidadPedido, let precio = precio_recibido, let costoEnvio = costoEntrega_recibido
        {
            
            /*print("Cantidad: $\(cantidad)")
            print("Precio: $\(precio)")
            print("Costo envio: $ \(Double(costoEnvio))")*/
            
            total = (cantidad * precio) + Double(costoEnvio)
            
            //print("Total: $\(total)")
            LBL_Total.text = "\(total)"
        }
        

    }
    
    @IBAction func BTN_HacerPedido(_ sender: UIButton) {
        let date = Date()
        
        let dateF = DateFormatter()
        
        dateF.locale = Locale(identifier: "es_MX")
        dateF.dateStyle = .short
        print("DATOS PARA EL INSERT")
        
        let defaults = UserDefaults.standard
        
        print("Fecha: \(dateF.string(from: date))")
        print("Cantidad: \(cantidadPedido!)")
        print("Total: \(total)")
        print("ID Platillo: \(idPlatillos_recibido)")
        print("ID Usuario: \(defaults.value(forKey: "id_usuario") as? Int)")
    }
}
