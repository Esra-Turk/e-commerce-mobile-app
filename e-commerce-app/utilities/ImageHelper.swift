//
//  ImageHelper.swift
//  e-commerce-app
//
//  Created by Esra Türk on 9.10.2024.
//

import Foundation
import UIKit
import Kingfisher

class ImageHelper {
    static func showImage(for imageView: UIImageView, urlString: String?) {
        let url = API.Endpoints.fetchProductImage(for: urlString!)
        
        if let u = URL(string: url) {
            DispatchQueue.main.async {
                imageView.kf.setImage(with: u)
            }
            
        }
    }
}
