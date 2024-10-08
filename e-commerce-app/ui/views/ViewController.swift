//
//  ViewController.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = HomepageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProducts()
        
    }


}

