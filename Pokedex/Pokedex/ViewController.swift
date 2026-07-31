//
//  ViewController.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewYellow: UIView!
    
    // MARK: - Funciones Inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
                    self.imgView.transform = CGAffineTransform(scaleX: 18, y: 18)
                    self.imgView.alpha = 0.0
                    self.viewYellow.alpha = 0.0
                }) { finished in
                    if finished {
                        let vc = NavigationBridge().create(.homeVC)
                        let nvc = UINavigationController(rootViewController: vc)
                        nvc.modalPresentationStyle = .fullScreen
                        nvc.isNavigationBarHidden = true
                        self.present(nvc, animated: false, completion: nil)
                    }
                }
    }
}

