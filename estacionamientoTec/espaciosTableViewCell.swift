//
//  espaciosTableViewCell.swift
//  estacionamientoTec
//
//  Created by Mac19 on 09/07/21.
//

import UIKit

class espaciosTableViewCell: UITableViewCell {

    @IBOutlet weak var espacioLabel: UILabel!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var botonAc: UIButton!
    
    var nombreE: String!
    var estadoE: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func accionar(_ sender: UIButton) {
        if estadoE == "1" {
            botonAc.tintColor = UIColor.red
        }
        
    }
}
