//
//  OnboardingViewController.swift
//  estacionamientoTec
//
//  Created by Mac19 on 09/07/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var diapositivas: [OnboardingDia] = []
    
    @IBOutlet weak var onboardingCV: UICollectionView!
    
    @IBOutlet weak var control: UIPageControl!
    @IBOutlet weak var botonSig: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diapositivas = [
            OnboardingDia(titulo: "Inicio", desc: "Registrate o inicia sesion", imagen: #imageLiteral(resourceName: "1")),
            OnboardingDia(titulo: "Registrate", desc: "Llena tus datos y registrate", imagen: #imageLiteral(resourceName: "2")),
            OnboardingDia(titulo: "Selecciona", desc: "Elige el espacio que se va a ocupar", imagen: #imageLiteral(resourceName: "3")),
            OnboardingDia(titulo: "Encuentra tu espacio", desc: "Observa el croquis y ubica tu espacio", imagen: #imageLiteral(resourceName: "4"))
            
            
        ]
        onboardingCV.delegate = self
        onboardingCV.dataSource = self
        
        
    }
    

    @IBAction func btnSigClick(_ sender: UIButton) {
    }
    

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diapositivas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = onboardingCV.dequeueReusableCell(withReuseIdentifier: "OnboardinCollectionViewCell", for: indexPath) as! OnboardinCollectionViewCell
        celda.configurar(diapositiva: diapositivas[indexPath.row])
        return celda
    }
    
    
}
