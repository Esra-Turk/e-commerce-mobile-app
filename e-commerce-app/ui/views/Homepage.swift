//
//  ViewController.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class Homepage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var technologyButton: UIButton!
    @IBOutlet weak var accessoryButton: UIButton!
    @IBOutlet weak var cosmeticButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel = HomepageViewModel()
    var productList = [Product]()
    var reviewCounts: [Int] = []
    var searchTextField: UITextField!
    var images = ["banner1", "banner2","banner3"]
    var timer: Timer?
    var currentIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        setupNavigationController()
        self.tabBarController?.tabBar.tintColor = UIColor(named: "button-orange")
        
        selectButton(allButton)
        setButtonStyle(button: sortButton)
        setupImagesInScrollView()
        startTimer()
        
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
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        showSearchField()
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        showSortActionSheet(on: self)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        resetButtons()
        selectButton(sender)
        
        switch sender {
        case allButton:
            viewModel.filterProducts(by: "All")
            categoryNameLabel.text = "Tüm Ürünler"
        case technologyButton:
            viewModel.filterProducts(by: "Teknoloji")
            categoryNameLabel.text = "Teknoloji"
        case accessoryButton:
            viewModel.filterProducts(by: "Aksesuar")
            categoryNameLabel.text = "Aksesuar"
        case cosmeticButton:
            viewModel.filterProducts(by: "Kozmetik")
            categoryNameLabel.text = "Kozmetik"
        default:
            break
        }
    }
    
    @objc func showSearchField() {
        if searchTextField == nil {
            searchTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
            searchTextField.placeholder = "Ürünlerde Ara"
            searchTextField.borderStyle = .roundedRect
            searchTextField.delegate = self
        }

        navigationItem.titleView = searchTextField
        searchTextField.becomeFirstResponder()
    }
    
    // Klavyeden her bir karakter girişini dinler
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        filterContentForSearchText(currentText)
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        navigationItem.titleView = nil
        return true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.searchProduct(productName: searchText)

    }
    
    private func selectButton(_ button: UIButton) {
        button.backgroundColor = UIColor(named: "button-orange")
        button.setTitleColor(UIColor.white, for: .selected)
        button.isSelected = true
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
    }
    
    private func resetButtons() {
         let buttons = [allButton,technologyButton,accessoryButton,cosmeticButton]
         for button in buttons {
             button?.backgroundColor = UIColor.systemGray5
             button?.setTitleColor(UIColor(named: "title-color"), for: .normal)
             button?.isSelected = false
             button?.layer.cornerRadius = 8
             button?.layer.masksToBounds = true
         }
     }
    
    private func setButtonStyle(button:UIButton) {
        button.layer.borderWidth = 0.7
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    private func showSortActionSheet(on viewController: UIViewController) {
        let actionSheet = UIAlertController(title: "Sırala", message: nil, preferredStyle: .actionSheet)

        let lowestPriceAction = UIAlertAction(title: "En düşük fiyat", style: .default) { [self] _ in
            self.productList = productList.sorted(by: {$0.fiyat! < $1.fiyat!})
            
            DispatchQueue.main.async {
                self.collectionViewProduct.reloadData()
            }
            
        }
        
        let highestPriceAction = UIAlertAction(title: "En yüksek fiyat", style: .default) { [self] _ in
            self.productList = productList.sorted(by: {$0.fiyat! > $1.fiyat!})
            
            DispatchQueue.main.async {
                self.collectionViewProduct.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        lowestPriceAction.setValue(UIColor(named: "button-orange"), forKey: "titleTextColor")
        highestPriceAction.setValue(UIColor(named: "button-orange"), forKey: "titleTextColor")
        cancelAction.setValue(UIColor.black, forKey: "titleTextColor")

        actionSheet.addAction(lowestPriceAction)
        actionSheet.addAction(highestPriceAction)
        actionSheet.addAction(cancelAction)

        if let subview = actionSheet.view.subviews.first?.subviews.first?.subviews.first {
            subview.backgroundColor = UIColor.white
        }

        viewController.present(actionSheet, animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let product = sender as? Product {
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
    
    private func setupImagesInScrollView() {
          scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(images.count), height: view.frame.height)
          
          for i in 0..<images.count {
              let imageView = UIImageView()
              imageView.image = UIImage(named: images[i])
              imageView.contentMode = .scaleAspectFill
              imageView.clipsToBounds = true
              
              let xPosition = view.frame.width * CGFloat(i)
              imageView.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: 150)
              
              scrollView.addSubview(imageView)
          }
      }

      private func startTimer() {
          timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScrollImages), userInfo: nil, repeats: true)
      }
      
      // Zamanlayıcı tetiklendiğinde çalışacak fonksiyon
      @objc func autoScrollImages() {
          currentIndex += 1
          if currentIndex >= images.count {
              currentIndex = 0
          }
          
          let xOffset = CGFloat(currentIndex) * scrollView.frame.width
          scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
      }
      
      deinit {
          timer?.invalidate()
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
        cell.configure(with: product, viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: product)
        collectionView.deselectItem(at: indexPath, animated: false)
    }

}
