//
//  Profile.swift
//  e-commerce-app
//
//  Created by Esra Türk on 16.10.2024.
//

import UIKit

class Profile: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    
    let data = ["Siparişlerim", "Kuponlarım","Beğendiklerim", "Premiumlu Ol", "Müşteri Hizmetleri","Ayarlar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
            default:
                cell.button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        }
        
        return cell
    }
    
    
}
