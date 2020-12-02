//
//  LoadMoreCollectionViewCell.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 2.12.2020.
//

import UIKit

class LoadMoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var loadMoreButton: UIButton!
    
    var loadMoreTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadMoreButton.layer.borderWidth = 1
        loadMoreButton.layer.cornerRadius = loadMoreButton.frame.height / 2
        loadMoreButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func onLoadMore(_ sender: Any) {
        loadMoreTapped?()
    }
    
}
