//
//  MovieCollectionViewCell.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 30.11.2020.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var starButton: UIButton! // Not enabled
    
    var movie: Movie? {
        didSet {
            handleImage()
            movieTitleLabel.text = "  \(movie?.title ?? "")"
            starButton.isHidden = !FavManager.isFav(movie: movie)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }
    
    private func handleImage() {
        guard let imageUri = movie?.imageUri else {
            return
        }
        if let image = CacheManager.shared.getImage(identifier: imageUri) {
            movieImageView.image = image
        } else {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w400\(imageUri)")!
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    if let image = UIImage(data: data) {
                        self?.movieImageView.image = image
                        CacheManager.shared.cacheImage(image: image, identifier: imageUri)
                    }
                }
            }).resume()
        }
    }

}
