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
    
    typealias platillosCallback = (_ platillos:[Platillos]?, _ status:Bool, _ message:String) -> Void
    var callBack:platillosCallback?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        TBL_Platillos.dataSource = self
        
        TBL_Platillos.register(UINib(nibName: "Platillo_TableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        consultarPlatillos(URL: "http://\(const.dir_ip)/orderit/consultaRestaurantePedido.php")
        completitionHandler { [weak self](platillos, status, message) in
            if status
            {
                guard let self = self else {return}
                guard let _platillos = platillos else {return}
                self.platillos = _platillos
                self.TBL_Platillos.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platillos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = TBL_Platillos.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! Platillo_TableViewCell
        
        let plat = platillos[indexPath.row]
        
        celda.LBL_Nombre_Restaurante.text = plat.nombreRest
        celda.LBL_Tiempo_Entrega.text = "Tiempo estimado de entrega: \(plat.tiempoEstimado ?? "")"
        celda.LBL_Costo_Entrega.text = "Costo de entrega: $\(plat.costoEntrega ?? 0)"
        
        celda.LBL_Platillo_Static.text = "Platillo"
        celda.LBL_Nombre_Platillo.text = plat.nombrePlatillo
        
        celda.LBL_Costo_Static.text = "Costo"
        celda.LBL_Costo_Platillo.text = "$\(plat.precio ?? 0)"
        
        return celda
    }
    

    func consultarPlatillos(URL:String)
    {
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
            guard let data = responseData.data else {
                
                self.callBack?(nil, false, "")
                
                return }
            
            do
            {
                let platillos = try JSONDecoder().decode([Platillos].self, from: data)
                
                self.callBack?(platillos, true, "")
                /*if let idRestaurante = platillos[1].idRestaurante
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
                }*/
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completitionHandler(callBack: @escaping platillosCallback)
    {
        self.callBack = callBack
    }

}
