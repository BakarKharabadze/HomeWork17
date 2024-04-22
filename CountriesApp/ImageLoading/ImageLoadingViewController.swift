//
//  ImageLoadingViewController.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/22/24.
//

import UIKit

class ImageLoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
