//
//  Cart.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class Cart: UIViewController {
    
    @IBOutlet weak var numberOfProduct: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var viewModel = CartViewModel()
    var cartItemList = [UrunlerSepeti]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCartItems()

        // Do any additional setup after loading the view.
    }
    


}
