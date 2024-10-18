//
//  Profile.swift
//  e-commerce-app
//
//  Created by Esra Türk on 16.10.2024.
//

import UIKit

class Profile: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    let data = ["Siparişlerim", "Kuponlarım","Beğendiklerim", "Premiumlu Ol", "Müşteri Hizmetleri","Ayarlar","Çıkış Yap"]
    private var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationController()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAndUpdateUI()
    }
    
    private func fetchAndUpdateUI() {
         viewModel.fetchUserData { [weak self] in
             DispatchQueue.main.async {
                 self?.updateUIBasedOnUserStatus()
             }
         }
     }
    
    private func updateUIBasedOnUserStatus() {
        if let profile = viewModel.user {
             // Kullanıcı giriş yapmışsa butonları gizle kullanıcı adını ve profil resmini göster
             registerbutton.isHidden = true
             loginButton.isHidden = true
             userNameLabel.isHidden = false
             profileImage.isHidden = false
             userNameLabel.text = profile.fullName ?? "Kullanıcı"
             self.navigationItem.title = "Profilim"
         } else {
             registerbutton.isHidden = false
             loginButton.isHidden = false
             userNameLabel.isHidden = true
             profileImage.isHidden = true
             self.navigationItem.title = "Misafir Kullanıcı"
         }
     }
    
    func signOutUser() {
        viewModel.signOutUser { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Çıkış yapılırken hata oluştu: \(error.localizedDescription)")
                } else {
                    print("Kullanıcı başarıyla çıkış yaptı.")
                    self?.fetchAndUpdateUI() // Çıkıştan sonra UI'yi güncelle
                }
            }
        }
    }
    
    private func setupNavigationController() {
         let backButton = UIBarButtonItem()
         backButton.title = "Geri"
         backButton.tintColor = UIColor(named: "button-orange")
         navigationItem.backBarButtonItem = backButton
     }
}

extension Profile:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileListCell") as! ProfileListCell
        
        cell.titleLabel.text = data[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        switch indexPath.row {
            case 0:
                cell.button.setImage(UIImage(systemName: "archivebox"), for: .normal)
            case 1:
                cell.button.setImage(UIImage(systemName: "ticket"), for: .normal)
            case 2:
                cell.button.setImage(UIImage(systemName: "heart"), for: .normal)
            case 3:
                cell.button.setImage(UIImage(systemName: "diamond"), for: .normal)
            case 4:
                cell.button.setImage(UIImage(systemName: "gearshape"), for: .normal)
            case 5:
                cell.button.setImage(UIImage(systemName: "person.wave.2"), for: .normal)
            case 6:
                cell.button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
            default:
                cell.button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          switch indexPath.row {
          case 6:
              signOutUser()
          default:
              print("\(data[indexPath.row]) hücresi seçildi")
          }
      }
    
    
}
