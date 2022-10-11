//
//  SearchedItemViewController.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/7/22.
//

import UIKit

class SearchedItemViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleOfItem: UILabel!
    @IBOutlet weak var brandNameOfItem: UILabel!
    @IBOutlet weak var ratingOfItem: UILabel!
    
    
    
    var product: Product?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    
    func updateViews() {
        guard let product = product else {
            return
        }
        titleOfItem.text = product.title
        brandNameOfItem.text = product.brand
        ratingOfItem.text = " Rating: \(product.rating ?? 0)"
        
        guard let productImageString = product.image else { return }
        
        NetworkController.fetchImage(with: productImageString) { [weak self] results in
            switch results {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.itemImage.image = image
                }
            case .failure(let error):
                print("There has been an error", error.errorDescription!)
            }
        }
    }
    
}
