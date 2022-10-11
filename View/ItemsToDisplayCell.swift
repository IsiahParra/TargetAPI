//
//  TableViewCell.swift
//  TargetAPI
//
//  Created by Isiah Parra on 10/7/22.
//

import UIKit

class ItemsToDisplayCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        itemTitleLabel.text = nil
    }
    
    func updateViews(with product: Product) {
        itemTitleLabel.text = product.title
        fetchImage(for: product)
    }
    
    func fetchImage(for searchItem: Product) {
        guard let imageString = searchItem.image else {
            return
        }
        NetworkController.fetchImage(with: imageString) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.itemImageView.image = image
                }
            case .failure(let error):
                print("there has been an error", error.errorDescription!)
            }
        }
    }
}
