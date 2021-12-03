//
//  ListaPedidos_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 02/12/21.
//

import UIKit

class ListaPedidos_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var TBL_Lista_Pedidos: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        TBL_Lista_Pedidos.dataSource = self
        TBL_Lista_Pedidos.delegate = self
        
        TBL_Lista_Pedidos.register(UINib(nibName: "Pedido_TableViewCell", bundle: nil), forCellReuseIdentifier: "celdaPedidos")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = TBL_Lista_Pedidos.dequeueReusableCell(withIdentifier: "celdaPedidos", for: indexPath) as! Pedido_TableViewCell
        
        celda.LBL_Nombre_Restaurante.text = "Hamburguesas Mi Barrio"
        celda.LBL_Fecha_Pedido.text = "21/11/2021"
        celda.LBL_Costo_Entrega_Pedido.text = "$34"
        celda.LBL_Nombre_Platillo_Pedido.text = "Papas a la Francesa"
        celda.LBL_Costo_Platillo_Pedido.text = "$60"
        celda.LBL_Cantidad_Pedido.text = "2"
        celda.LBL_Total_Pedido.text = "$154"
        
        return celda
    }


}
