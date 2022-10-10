//
//  ViewController.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import UIKit

class ViewController<Media: MediaProtocol>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating{
    
    // MARK: - Properties
    private let mainView = MainCollectionView()
    private let networkService = BaseNetworkService()
    private var mediaResponse: Response<Media>? {
        didSet{
            mainView.refresh()
        }
    }
    
    private var mediaName = ""
    
    // MARK: - Lifecycle
    init(_ mediaName: String) {
        self.mediaName = mediaName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Education, Fun..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addTapped))
        
        // adjust default searching parameter
        fetchMedia(with: "\(Media.self)".lowercased())
    }
    
    // MARK: - define button action
    @objc func addTapped(){
        let favouritesViewController = FavouritesPageViewController()
        navigationController?.pushViewController(favouritesViewController, animated: true)
    }
    
    // MARK: - Methods
    private func fetchMedia(with text: String) {
        networkService.request(Request<Response<Media>>(searchText: text, mediaName: mediaName)) { result in
            switch result{
            case .success(let response):
                self.mediaResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: -UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController<Media>()
        detailViewController.mediaItem = mediaResponse?.results?[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mediaResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let media = mediaResponse?.results?[indexPath.row]
        cell.title = media?.name
        cell.imageView.downloadImage(from: media?.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchMedia(with: text)
        }else{
            fetchMedia(with: "\(Media.self)".lowercased())
        }
    }
}
