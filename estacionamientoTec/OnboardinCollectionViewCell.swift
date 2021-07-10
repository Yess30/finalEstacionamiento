//
//  OnboardinCollectionViewCell.swift
//  estacionamientoTec
//
//  Created by Mac19 on 09/07/21.
//

import UIKit

class OnboardinCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagenDiaIV: UIImageView!
    @IBOutlet weak var tituloL: UILabel!
    @IBOutlet weak var descL: UILabel!
    
    func configurar(diapositiva: OnboardingDia ){
        imagenDiaIV.image = diapositiva.imagen
        tituloL.text = diapositiva.titulo
        descL.text = diapositiva.desc
    }
}
