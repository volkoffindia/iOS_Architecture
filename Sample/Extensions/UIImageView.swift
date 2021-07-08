//
//  UIImageView.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    /*
     * Method name: loadImage
     * Description: use to load image from url
     * Parameters: strURL refer url and placeHolder refer placehoder image name
     * Return:  -
     */

    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    self.image = image
                }
            }).resume()
        }
    }
}
