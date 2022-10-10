//
//  DetailsView.swift
//  hw3
//
//  Created by Berksu Kısmet on 8.10.2022.
//

import UIKit
import CoreData

class DetailsView: UIView {
    
    // MARK: - define computed properties
    var releaseDate: String? {
        didSet {
            // When release date set, update labels
            releaseDateKeyLabel.text = "Release Date: "
            releaseDateKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            releaseDateLabel.text = prettyReleaseDate
        }
    }
    
    // for showing date pretty
    var prettyReleaseDate: String {
        guard let releaseDate = releaseDate else { return "" }
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let oldDate = olDateFormatter.date(from: releaseDate)

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd-MM-yyyy"

        return convertDateFormatter.string(from: oldDate!)
    }
    
    
    var artistName: String? {
        didSet{
            artistNameKeyLabel.text = "Name: "
            artistNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            artistNameLabel.text = artistName ?? "-"
        }
    }
    
    var price: Double? {
        didSet{
            priceKeyLabel.text = "Price: "
            priceKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            if let price = price{
                priceLabel.text = (price == 0.0) ? "Free" : "\(price) $"
            }else{
                priceLabel.text =  "-"
            }
        }
    }
    
    var artworkLarge: URL? = URL(string: "")
    var trackID: Int?{
        didSet{
            // When trackID set, control this id in favourites and update buttons according to this information
            guard let trackID = trackID else { return}
            if(CoreDataProcess.shared.favouritesMediaNames.contains(trackID)){
                addToFavouriteButton.isHidden = true
                removeFromFavouriteButton.isHidden = false
            }else{
                addToFavouriteButton.isHidden = false
                removeFromFavouriteButton.isHidden = true
            }
        }
    }
    


    // MARK: - Define UIImageView
    private(set) var imageView =  UIImageView()
    
    // MARK: - Define UILabels
    private let releaseDateLabel = UILabel()
    private let releaseDateKeyLabel = UILabel()
    private lazy var releaseDateStackView = {
       //let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, UIView(), releaseDateLabel])
        let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, releaseDateLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let artistNameKeyLabel = UILabel()
    private let artistNameLabel = UILabel()
    private lazy var artistNameStackView = {
       let stackView = UIStackView(arrangedSubviews: [artistNameKeyLabel, artistNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let priceKeyLabel = UILabel()
    private let priceLabel = UILabel()
    private lazy var priceStackView = {
       let stackView = UIStackView(arrangedSubviews: [priceKeyLabel, priceLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let genresKeyLabel = UILabel()
    private let genresLabel = UILabel()
    private lazy var genresStackView = {
       let stackView = UIStackView(arrangedSubviews: [genresKeyLabel, genresLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    // MARK: - Define UIButtons
    private let addToFavouriteButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Add To Favourites", for: .normal)
        button.addTarget(self, action: #selector(addToFavouriteButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let removeFromFavouriteButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .red
        button.setTitle("Remove From Favourites", for: .normal)
        button.addTarget(self, action: #selector(removeFromFavouriteButtonAction), for: .touchUpInside)
        return button
    }()
    
    // - MARK: Button Methods
    @objc func addToFavouriteButtonAction(sender: UIButton!) {
        // add item to database
        CoreDataProcess.shared.addItem(trackID: trackID,
                                       name: artistName,
                                       price: price,
                                       releaseDate: releaseDate,
                                       artworkLarge: artworkLarge?.absoluteString)
        //update buttons
        removeFromFavouriteButton.isHidden = false
        addToFavouriteButton.isHidden = true
    }
    
    @objc func removeFromFavouriteButtonAction(sender: UIButton!) {
        // remove form database
        guard let trackID = trackID else { return }
        CoreDataProcess.shared.delete(trackID)
        //Update buttons
        removeFromFavouriteButton.isHidden = true
        addToFavouriteButton.isHidden = false
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        releaseDateLabel.numberOfLines = .zero
        artistNameLabel.numberOfLines = 2
        priceLabel.numberOfLines = .zero
        genresLabel.numberOfLines = .zero
        
        // Add imageView and add constraints to imageView
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .screenWidth * 3/4)
        ])
        
        // Add all views in stack view
        let stackView = UIStackView(arrangedSubviews: [artistNameStackView,
                                                       releaseDateStackView,
                                                       priceStackView,
                                                       addToFavouriteButton,
                                                      removeFromFavouriteButton])
        

        
        stackView.axis = .vertical
        stackView.spacing = 12.0
        addSubview(stackView)
        
        // Add constraints to stackview
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
        
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
