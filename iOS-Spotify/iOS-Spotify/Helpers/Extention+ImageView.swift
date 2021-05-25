//
//  Extention+ImageView.swift
//  iOS-Spotify
//
//  Created by Ignatio Julian on 25/05/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        let kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}
