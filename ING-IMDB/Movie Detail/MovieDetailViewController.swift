//
//  MovieDetailViewController.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 1.12.2020.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieVoteCountLabel: UILabel!
    @IBOutlet weak var movieStarButton: UIButton!
    
    var movie: Movie?
    var change = false
    var changeHappened: ((Bool, IndexPath?) -> Void)?
    
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        changeHappened?(change, indexPath)
    }
    
    private func setupView() {
        guard let movie = movie else {
            return
        }
        if let posterUri = movie.imageUri {
            handleImage(posterUri: posterUri)
        }
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        movieVoteCountLabel.text = "Voted:\n\(movie.voteCount ?? 0)"
        handleStar()
    }
    
    private func handleImage(posterUri: String) {
        if let image = CacheManager.shared.getImage(identifier: posterUri) {
            movieImageView.image = image
        } else {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w400\(posterUri)")!
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    if let image = UIImage(data: data) {
                        self?.movieImageView.image = image
                        CacheManager.shared.cacheImage(image: image, identifier: posterUri)
                    }
                }
            }).resume()
        }
    }
    
    private func handleStar() {
        movieStarButton.setImage(UIImage(systemName: FavManager.isFav(movie: movie) ? "star.fill" : "star"),
                                 for: .normal)
    }
    
    @IBAction func onStar(_ sender: Any) {
        if FavManager.isFav(movie: movie) {
            FavManager.unFav(movie: movie, completion: { [weak self] in
                self?.handleStar()
            })
        } else {
            FavManager.fav(movie: movie, completion: { [weak self] in
                self?.handleStar()
            })
        }
        change = true
    }
    
}
