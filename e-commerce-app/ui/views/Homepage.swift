//
//  ViewController.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class Homepage: UIViewController {
    
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    
    var viewModel = HomepageViewModel()
    var productList = [Urunler]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()

        _ = viewModel.productsList.subscribe(
            onNext: { list in
                self.productList = list
                DispatchQueue.main.async {
                    self.collectionViewProduct.reloadData()
                }
            }, onError: { error in
                print("Error fetching products: \(error)")
            }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getProducts()
    }
    
    private func setupCollectionViewLayout() {
          let cellDesign = UICollectionViewFlowLayout()
          cellDesign.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
          cellDesign.minimumInteritemSpacing = 5
          cellDesign.minimumLineSpacing = 15
          collectionViewProduct.collectionViewLayout = cellDesign
          
          let screenWidth = UIScreen.main.bounds.width
          let totalPadding: CGFloat = 50
          let itemWidth = (screenWidth - totalPadding - 5) / 2
          cellDesign.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
      }
    
}

extension Homepage: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewProduct.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! HomeProductCell
        let product = productList[indexPath.row]
        
        ImageHelper.showImage(for: cell.productImageView, urlString: product.resim)
        cell.productNameLabel.text = product.ad
        cell.priceLabel.text = "\(product.fiyat!) ₺"
        cell.productReviewsLabel.text  = "\(Int.random(in: 50...200)) değerlendirme"
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }

}
