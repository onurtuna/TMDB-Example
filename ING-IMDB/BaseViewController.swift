//
//  BaseViewController.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 2.12.2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
