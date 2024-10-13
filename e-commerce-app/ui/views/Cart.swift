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
    @IBOutlet weak var productsTableView: UITableView!
    
    var viewModel = CartViewModel()
    var cartItemList = [UrunlerSepeti]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCartItems()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCartItems()
        
        _ = viewModel.cartItemList.subscribe(onNext: {list in
            self.cartItemList = list
            DispatchQueue.main.async{
                self.productsTableView.reloadData()
            }
        })
    }

}

extension Cart:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartProductCell") as! CartProductCell
        let product = cartItemList[indexPath.row]
        
        cell.productNameLabel.text = product.ad
        ImageHelper.showImage(for: cell.productImageView, urlString: product.resim)
        cell.productBrandLabel.text = product.marka
        cell.productPriceLabel.text = "\(product.fiyat!) ₺"
        cell.productQuantityLabel.text = "\(product.siparisAdeti!)"
        
        cell.selectionStyle = .none
        cell.customView.layer.shadowColor = UIColor.gray.cgColor
        cell.customView.layer.shadowOpacity = 0.5
        cell.customView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.customView.layer.shadowRadius = 3
        cell.customView.layer.masksToBounds = false
        
        cell.onRemoveButtonTapped = { [weak self] in
            self?.viewModel.remevoCartItem(cartID: product.sepetId!)
        }
        return cell
    }
    
}
