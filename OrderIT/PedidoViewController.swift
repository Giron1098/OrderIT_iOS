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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LBL_NombreRestaurante.text = nombreRest_recibido
        
        print(nombrePlatillo_recibido)
        LBL_NombrePlatillo.text = nombrePlatillo_recibido
        LBL_CostoPlatillo.text = "\(precio_recibido!)"
        
        LBL_CostoEntrega.text = "\(costoEntrega_recibido!)"
        
    }
    
    @IBAction func STPR_Cantidad(_ sender: UIStepper) {
        let cantidad:Int = Int(sender.value)
        
        LBL_Cantidad.text = "\(cantidad)"
    }
    
    @IBAction func BTN_CalcularTotal(_ sender: UIButton) {
    }
    
    @IBAction func BTN_HacerPedido(_ sender: UIButton) {
    }
}
