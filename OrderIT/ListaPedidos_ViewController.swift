//
//  ListaPedidos_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 02/12/21.
//

import UIKit
import Alamofire

class ListaPedidos_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var TBL_Lista_Pedidos: UITableView!
    
    var const = Constantes()
    
    struct Pedidos: Codable{
        var idPedidos:String?
        var fecha:String?
        var cantidad:String?
        var total:String?
        var nombrePlatillo:String?
        var precio:String?
        var nombreRest:String?
        var costoEntrega:String?
        var direccion:String?
    }
    
    var pedidos = [Pedidos]()
    
    typealias pedidosCallback = (_ pedidos:[Pedidos]?, _ status:Bool, _ message:String) -> Void
    var callBack:pedidosCallback?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        TBL_Lista_Pedidos.dataSource = self
        TBL_Lista_Pedidos.delegate = self
        
        let defaults = UserDefaults.standard
        
        if let correo = defaults.value(forKey: "correo") as? String, let password = defaults.value(forKey: "password") as? String, let id_usuario = defaults.value(forKey: "id_usuario") as? Int
        {
            consultarPedidos(URL: "http://\(const.dir_ip)/orderit/consultaPedidos.php?idUsuario=\(id_usuario)")
            
            completitionHandler { [weak self](pedidos, status, message) in
                if status
                {
                    guard let self = self else {return}
                    guard let _pedidos = pedidos else {return}
                    self.pedidos = _pedidos
                    self.TBL_Lista_Pedidos.reloadData()
                }
            }
        }
        
        
        
        TBL_Lista_Pedidos.register(UINib(nibName: "Pedido_TableViewCell", bundle: nil), forCellReuseIdentifier: "celdaPedidos")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        
        if let correo = defaults.value(forKey: "correo") as? String, let password = defaults.value(forKey: "password") as? String, let id_usuario = defaults.value(forKey: "id_usuario") as? Int
        {
            consultarPedidos(URL: "http://\(const.dir_ip)/orderit/consultaPedidos.php?idUsuario=\(id_usuario)")
            
            completitionHandler { [weak self](pedidos, status, message) in
                if status
                {
                    guard let self = self else {return}
                    guard let _pedidos = pedidos else {return}
                    self.pedidos = _pedidos
                    self.TBL_Lista_Pedidos.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = TBL_Lista_Pedidos.dequeueReusableCell(withIdentifier: "celdaPedidos", for: indexPath) as! Pedido_TableViewCell
        
        let pedido = pedidos[indexPath.row]
        
        celda.LBL_Nombre_Restaurante.text = pedido.nombreRest
        celda.LBL_Fecha_Pedido.text = pedido.fecha
        celda.LBL_Costo_Entrega_Pedido.text = "$\(pedido.costoEntrega ?? "")"
        celda.LBL_Nombre_Platillo_Pedido.text = pedido.nombrePlatillo
        celda.LBL_Costo_Platillo_Pedido.text = "$\(pedido.precio ?? "")"
        celda.LBL_Cantidad_Pedido.text = pedido.cantidad
        celda.LBL_Total_Pedido.text = "$\(pedido.total ?? "")"
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        TBL_Lista_Pedidos.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "rastreoPedido", sender: self)
    }
    
    func consultarPedidos(URL:String)
    {
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { ( responseData ) in
            guard let data = responseData.data else {
                
                self.callBack?(nil, false, "")
                
                return }
            
            do
            {
                let pedidos = try JSONDecoder().decode([Pedidos].self, from: data)
                
                self.callBack?(pedidos, true, "")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completitionHandler(callBack: @escaping pedidosCallback)
    {
        self.callBack = callBack
    }


}
