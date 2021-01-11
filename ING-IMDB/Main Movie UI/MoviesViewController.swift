//
//  MoviesViewController.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 30.11.2020.
//

import UIKit

class MoviesViewController: BaseViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var filteredMovies: Array<Movie>?
    
    private var movieCollectionCell = "MovieCollectionViewCell"
    private var loadMoreCollectionCell = "LoadMoreCollectionViewCell"
    private var listName = "rectangle.grid.1x2.fill"
    private var gridName = "rectangle.grid.2x2.fill"
    private var isGrid = false
    var movieViewModel = MovieViewModel()
    private var numberOfColumns = 1 {
        didSet {
            if movieCollectionView != nil {
                movieCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionItems()
        setupViewModel()
        movieViewModel.fetchMovies(of: movieViewModel.currentPage)
        setupNavigationBar()
    }
    
    @objc private func onChangeGrid() {
        numberOfColumns = numberOfColumns == 1 ? 2 : 1
        handleListGrid()
    }
    
    func filterMoviesForSearchText(_ searchText: String) {
        filteredMovies = movieViewModel.movies?.filter { (movie: Movie) -> Bool in
            return (movie.title?.lowercased().contains(searchText.lowercased()) ?? false)
      }
      movieCollectionView.reloadData()
    }

    private func setupViewModel() {
        movieViewModel.errorOccured = { [weak self] message in
            self?.showAlert(message: message)
        }
        movieViewModel.moviesFetched = { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: gridName),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onChangeGrid))
        navigationItem.title = "Movies"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    
    private func handleListGrid() {
        isGrid = !isGrid
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: isGrid ? listName : gridName)
    }
    
    private func registerCollectionItems() {
        movieCollectionView.register(UINib(nibName: movieCollectionCell, bundle: nil), forCellWithReuseIdentifier: movieCollectionCell)
        movieCollectionView.register(UINib(nibName: loadMoreCollectionCell, bundle: nil), forCellWithReuseIdentifier: loadMoreCollectionCell)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }

}

extension MoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies?.count ?? 0
        }
        return (movieViewModel.movies?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isFiltering {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionCell, for: indexPath) as? MovieCollectionViewCell else {
                return MovieCollectionViewCell()
            }
            cell.movie = filteredMovies?[indexPath.row]
            return cell
        } else {
            if indexPath.row == (movieViewModel.movies?.count ?? 0) {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadMoreCollectionCell, for: indexPath) as? LoadMoreCollectionViewCell else {
                    return LoadMoreCollectionViewCell()
                }
                cell.loadMoreTapped = { [weak self] in
                    self?.movieViewModel.fetchMovies(of: self?.movieViewModel.currentPage)
                }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionCell, for: indexPath) as? MovieCollectionViewCell else {
                    return MovieCollectionViewCell()
                }
                cell.movie = movieViewModel.movies?[indexPath.row]
                return cell
            }
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movie = isFiltering ? filteredMovies?[indexPath.row] : movieViewModel.movies?[indexPath.row]
        movieDetailVC.indexPath = indexPath
        movieDetailVC.changeHappened = { [weak self] change, indexPath in
            guard let indexPath = indexPath else {
                return
            }
            if change {
                self?.movieCollectionView.reloadItems(at: [indexPath])
            }
        }
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == (movieViewModel.movies?.count ?? 0) {
            return CGSize(width: collectionView.bounds.width - 16, height: 50)
        }
        let size = Int((collectionView.bounds.width - 16) / CGFloat(numberOfColumns))
        return CGSize(width: size, height: 250)
    }
    
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text else {
            return
        }
        filterMoviesForSearchText(searchText)
    }
}
