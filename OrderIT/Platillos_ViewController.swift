//
//  Platillos_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 24/11/21.
//

import UIKit
import Alamofire

class Platillos_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var TBL_Platillos: UITableView!
    
    var const = Constantes()
    
    struct Platillos: Codable{
        var idRestaurante: Int?
        var nombreRest:String?
        var direccion:String?
        var horario:String?
        var tiempoEstimado:String?
        var costoEntrega:Int?
        var idPlatillos:Int?
        var nombrePlatillo:String?
        var precio:Double?
    }
    
    var platillos = [Platillos]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        TBL_Platillos.dataSource = self
        
        TBL_Platillos.register(UINib(nibName: "Platillo_TableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        consultarPlatillos(URL: "http://\(const.dir_ip)/orderit/consultaRestaurantePedido.php")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = TBL_Platillos.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! Platillo_TableViewCell
        
        celda.LBL_Nombre_Restaurante.text = "El Tejaban"
        celda.LBL_Tiempo_Entrega.text = "Tiempo estimado de entrega: 55-65 min"
        celda.LBL_Costo_Entrega.text = "Costo de entrega: $25"
        
        celda.LBL_Platillo_Static.text = "Platillo"
        celda.LBL_Nombre_Platillo.text = "Mole Rojo con Pollo"
        
        celda.LBL_Costo_Static.text = "Costo"
        celda.LBL_Costo_Platillo.text = "$100.0"
        
        return celda
    }
    

    func consultarPlatillos(URL:String)
    {
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
            guard let data = responseData.data else { return }
            
            do
            {
                let platillos = try JSONDecoder().decode([Platillos].self, from: data)
                
                if let idRestaurante = platillos[1].idRestaurante
                {
                    if let nombreRest = platillos[1].nombreRest
                    {
                        if let direccion = platillos[1].direccion
                        {
                            if let horario = platillos[1].horario
                            {
                                if let tiempoEstimado = platillos[1].tiempoEstimado
                                {
                                    if let costoEntrega = platillos[1].costoEntrega
                                    {
                                        if let idPlatillos = platillos[1].idPlatillos
                                        {
                                            if let nombrePlatillo = platillos[1].nombrePlatillo
                                            {
                                                if let precio = platillos[1].precio
                                                {
                                                    print("\(idRestaurante)")
                                                    print(nombreRest)
                                                    print(direccion)
                                                    print(horario)
                                                    print(tiempoEstimado)
                                                    print("\(costoEntrega)")
                                                    print("\(idPlatillos)")
                                                    print(nombrePlatillo)
                                                    print(precio)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error decoding \(error)")
            }
        }
    }

}
