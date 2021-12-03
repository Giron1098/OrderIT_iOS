//
//  Pedido_TableViewCell.swift
//  OrderIT
//
//  Created by Mac4 on 03/12/21.
//

import UIKit

class Pedido_TableViewCell: UITableViewCell {

    @IBOutlet weak var LBL_Nombre_Restaurante: UILabel!
    @IBOutlet weak var LBL_Fecha_Pedido: UILabel!

    @IBOutlet weak var LBL_Costo_Entrega_Pedido: UILabel!
    
    
    @IBOutlet weak var LBL_Nombre_Platillo_Pedido: UILabel!
    
    @IBOutlet weak var LBL_Costo_Platillo_Pedido: UILabel!
    
    @IBOutlet weak var LBL_Cantidad_Pedido: UILabel!
    @IBOutlet weak var LBL_Total_Pedido: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
