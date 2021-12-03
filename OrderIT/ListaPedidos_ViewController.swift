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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = TBL_Lista_Pedidos.dequeueReusableCell(withIdentifier: "celdaPedidos", for: indexPath)
        
        celda.textLabel?.text = "Aqui van"
        celda.detailTextLabel?.text = "los pedidos"
        
        return celda
    }


}
