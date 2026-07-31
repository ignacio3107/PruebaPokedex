//
//  Loader.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import UIKit

class CustomLoader: UIViewController {
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.8
        return backgroundView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.gifImageWithName("loadingPokeball")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func show(on viewController: UIViewController, message: String = Constant.Loader.message) {
        viewController.view.endEditing(true)
        
        var target = viewController
        if let navBar = viewController.navigationController {
            target = navBar
        }
        
        guard let targetView = target.view else {
            return
        }
        backgroundView.frame = targetView.bounds
        
        let x = (targetView.frame.size.width / 2) - 84
        let y = (targetView.frame.size.height / 2) - 84
        imageView.frame = CGRect(x: x, y: y, width: 168, height: 168)
        
        DispatchQueue.main.async {
            targetView.addSubview(self.backgroundView)
            targetView.addSubview(self.imageView)
        }
    }
    
    func hide(on viewController: UIViewController) {
        DispatchQueue.main.async {
            self.backgroundView.removeFromSuperview()
            self.imageView.removeFromSuperview()
        }
    }
}
