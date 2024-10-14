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
    var reviewCounts: [Int] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        setupNavigationController()
        self.tabBarController?.tabBar.tintColor = UIColor(named: "button-orange")
        
        reviewCounts = (0..<12).map { _ in Int.random(in: 50...200) }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let product = sender as? Urunler {
                let destinationVC = segue.destination as! ProductDetail
                destinationVC.product = product
                
                if let index = productList.firstIndex(where: { $0 === product }) {
                    destinationVC.reviewCount = reviewCounts[index]
                }
            }
        }
    }
    
    private func setupCollectionViewLayout() {
          let cellDesign = UICollectionViewFlowLayout()
          cellDesign.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 50, right: 20)
          cellDesign.minimumInteritemSpacing = 5
          cellDesign.minimumLineSpacing = 15
          collectionViewProduct.collectionViewLayout = cellDesign
          
          let screenWidth = UIScreen.main.bounds.width
          let totalPadding: CGFloat = 50
          let itemWidth = (screenWidth - totalPadding - 5) / 2
          cellDesign.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
      }
    
    private func setupNavigationController(){
        let backButton = UIBarButtonItem()
        backButton.title = "Geri"
        backButton.tintColor = UIColor.black
        navigationItem.backBarButtonItem = backButton

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
        cell.productReviewsLabel.text = "\(reviewCounts[indexPath.row]) Değerlendirme"
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: product)
        collectionView.deselectItem(at: indexPath, animated: false)
    }

}
