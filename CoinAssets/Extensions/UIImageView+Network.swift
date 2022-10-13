//
//  UIImageView+Network.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import AlamofireImage

extension UIImageView {

    func load(with url: String) {
        
        guard let url = URL(string: url) else {
            image = nil
            return
        }

        af.setImage(
            withURL: url,
            cacheKey: url.absoluteString,
            placeholderImage: UIImage(),
            imageTransition: .crossDissolve(0.2)
        )
        
    }

}
