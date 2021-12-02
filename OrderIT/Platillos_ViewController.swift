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
    
    var idRestaurante_enviado: Int?
    var nombreRest_enviado:String?
    var direccion_enviado:String?
    var horario_enviado:String?
    var tiempoEstimado_enviado:String?
    var costoEntrega_enviado:Int?
    var idPlatillos_enviado:Int?
    var nombrePlatillo_enviado:String?
    var precio_enviado:Double?
    
    typealias platillosCallback = (_ platillos:[Platillos]?, _ status:Bool, _ message:String) -> Void
    var callBack:platillosCallback?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        TBL_Platillos.dataSource = self
        TBL_Platillos.delegate = self
        
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
    
    //Identificar cuando un elemento de la tabla se selecciona
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        TBL_Platillos.deselectRow(at: indexPath, animated: true)
        
        if let id_Restaurante = platillos[indexPath.row].idRestaurante, let NombreRest = platillos[indexPath.row].nombreRest, let direccion_rest = platillos[indexPath.row].direccion, let horario = platillos[indexPath.row].horario, let tiempoEstimado_rest = platillos[indexPath.row].tiempoEstimado, let costoEntrega_rest = platillos[indexPath.row].costoEntrega, let id_Platillos = platillos[indexPath.row].idPlatillos, let nombre_platillo = platillos[indexPath.row].nombrePlatillo, let precio_plat = platillos[indexPath.row].precio
        {
            print(id_Restaurante)
            print(NombreRest)
            print(direccion_rest)
            print(horario)
            print(tiempoEstimado_rest)
            print(costoEntrega_rest)
            print(id_Platillos)
            print(nombre_platillo)
            print(precio_plat)
            
            idRestaurante_enviado = id_Restaurante
            nombreRest_enviado = NombreRest
            direccion_enviado = direccion_rest
            horario_enviado = horario
            tiempoEstimado_enviado = tiempoEstimado_rest
            costoEntrega_enviado = costoEntrega_rest
            idPlatillos_enviado = id_Platillos
            nombrePlatillo_enviado = nombre_platillo
            precio_enviado = precio_plat
            
        }
        performSegue(withIdentifier: "enviarDatosPlatillo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviarDatosPlatillo"
        {
            let objDestino = segue.destination as! PedidoViewController
            
            objDestino.idRestaurante_recibido = idRestaurante_enviado
            objDestino.nombreRest_recibido = nombreRest_enviado
            objDestino.direccion_recibido = direccion_enviado
            objDestino.horario_recibido = horario_enviado
            objDestino.tiempoEstimado_recibido = tiempoEstimado_enviado
            objDestino.costoEntrega_recibido = costoEntrega_enviado
            objDestino.idPlatillos_recibido = idPlatillos_enviado
            objDestino.nombrePlatillo_recibido = nombrePlatillo_enviado
            objDestino.precio_recibido = precio_enviado
        }
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
