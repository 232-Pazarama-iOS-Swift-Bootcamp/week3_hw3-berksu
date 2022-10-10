//
//  DetailViewController.swift
//  hw3
//
//  Created by Berksu Kısmet on 8.10.2022.
//

import UIKit

final class DetailViewController<Media: MediaProtocol>: UIViewController {
    
    private let detailView = DetailsView()
    
    // If media item set, update the detail view variables
    var mediaItem: Media? {
        didSet{
            // set navigation view title
            title = "Media Details"
            detailView.imageView.downloadImage(from: mediaItem?.artworkLarge)
            detailView.releaseDate = mediaItem?.releaseDate
            detailView.artistName = mediaItem?.name
            detailView.price = mediaItem?.price
            detailView.artworkLarge = mediaItem?.artworkLarge
            detailView.trackID = mediaItem?.trackId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
    }
    
}
