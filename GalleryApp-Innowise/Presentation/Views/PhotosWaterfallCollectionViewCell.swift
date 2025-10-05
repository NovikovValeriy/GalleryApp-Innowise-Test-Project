//
//  PhotosWaterfallCollectionViewCell.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 1.10.25.
//

import UIKit

struct PhotosWaterfallCollectionViewCellValues {
    static let imageCornerRadius: CGFloat = 20
    static let labelFontSize: CGFloat = 12
    static let labelHeightFromFontMultiplier: CGFloat = 2
    static let labelPaddingFromCornerRadiusMultiplier: CGFloat = 0.25
    static let titlePadding = imageCornerRadius * labelPaddingFromCornerRadiusMultiplier
}

class PhotosWaterfallCollectionViewCell: UICollectionViewCell {
    typealias PWCVCValues = PhotosWaterfallCollectionViewCellValues
    static let identifier = "PhotosWaterfallCollectionViewCell"
    
    // MARK: - UI Elements
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = PWCVCValues.imageCornerRadius
        view.layer.masksToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: PWCVCValues.labelFontSize, weight: .semibold)
        label.textColor = .label
        label.text = " "
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    func configure(photo: Photo) {
        self.label.text = photo.description
        self.imageBackgroundView.backgroundColor = .red
    }
    
    // MARK: - UI Configuration
    
    private func imageBackgroundViewConfiguration() {
        contentView.addSubview(imageBackgroundView)
        NSLayoutConstraint.activate([
            imageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    private func imageViewConfiguration() {
        imageBackgroundView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor)
        ])
    }
    
    private func labelConfiguration() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PWCVCValues.titlePadding),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PWCVCValues.titlePadding),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PWCVCValues.titlePadding),
            label.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: PWCVCValues.titlePadding)
        ])
    }
    
    private func configureUI() {
        self.imageBackgroundViewConfiguration()
        self.imageViewConfiguration()
        self.labelConfiguration()
    }
    
    // MARK: - Lifecycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
