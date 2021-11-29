//
//  Platillo_TableViewCell.swift
//  OrderIT
//
//  Created by Mac4 on 28/11/21.
//

import UIKit

class Platillo_TableViewCell: UITableViewCell {
    @IBOutlet weak var LBL_Nombre_Restaurante: UILabel!
    @IBOutlet weak var LBL_Tiempo_Entrega: UILabel!
    @IBOutlet weak var LBL_Costo_Entrega: UILabel!
    
    @IBOutlet weak var LBL_Platillo_Static: UILabel!
    @IBOutlet weak var LBL_Nombre_Platillo: UILabel!
    
    @IBOutlet weak var LBL_Costo_Static: UILabel!
    @IBOutlet weak var LBL_Costo_Platillo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
