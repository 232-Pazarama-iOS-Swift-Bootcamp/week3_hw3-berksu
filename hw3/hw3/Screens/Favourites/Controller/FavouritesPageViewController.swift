//
//  FavouritesPageViewController.swift
//  hw3
//
//  Created by Berksu Kısmet on 9.10.2022.
//

import UIKit
import CoreData

class FavouritesPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    // MARK: - Properties
    private let favouritesView = FavouritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        view = favouritesView
        favouritesView.setCollectionViewDelegate(self, andDataSource: self)

        CoreDataProcess.shared.fetchCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouritesView.refresh()
    }
    
    
    // MARK: -UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController<Favourites>()
        detailViewController.mediaItem = CoreDataProcess.shared.favouritesArray[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CoreDataProcess.shared.favouritesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let media = CoreDataProcess.shared.favouritesArray[indexPath.row]
        cell.title = media.name
        cell.imageView.downloadImage(from: media.artworkLarge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
}
