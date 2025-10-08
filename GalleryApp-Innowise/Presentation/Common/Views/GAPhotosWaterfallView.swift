//
//  GAPhotosWaterfallView.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import UIKit
import CHTCollectionViewWaterfallLayout

enum GAWaterfallCollectionViewSections: Int {
    case main
}

final class GAPhotosWaterfallView: UIView {

    weak var delegate: CHTCollectionViewDelegateWaterfallLayout? {
        didSet {
            collectionView.delegate = delegate
        }
    }
    
    var columnSpacing: CGFloat = 0 {
        didSet {
            let layout = (collectionView.collectionViewLayout as? CHTCollectionViewWaterfallLayout)
            layout?.minimumColumnSpacing = columnSpacing
            layout?.invalidateLayout()
        }
    }
    
    var interitemSpacing: CGFloat = 0 {
        didSet {
            let layout = (collectionView.collectionViewLayout as? CHTCollectionViewWaterfallLayout)
            layout?.minimumInteritemSpacing = interitemSpacing
            layout?.invalidateLayout()
        }
    }
    
    var itemRenderDirection: CHTCollectionViewWaterfallLayout.ItemRenderDirection = .shortestFirst {
        didSet {
            let layout = (collectionView.collectionViewLayout as? CHTCollectionViewWaterfallLayout)
            layout?.itemRenderDirection = itemRenderDirection
            layout?.invalidateLayout()
        }
    }
    
    var columnCount: Int = 2 {
        didSet {
            let layout = (collectionView.collectionViewLayout as? CHTCollectionViewWaterfallLayout)
            layout?.columnCount = columnCount
            layout?.invalidateLayout()
        }
    }
    
    // MARK: - UI Configuration
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = self.itemRenderDirection
        layout.minimumColumnSpacing = self.columnSpacing
        layout.minimumInteritemSpacing = self.interitemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WaterfallCollectionViewCell.self, forCellWithReuseIdentifier: WaterfallCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private func collectionViewConfig() {
        
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func configureUI() {
        collectionViewConfig()
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionViewConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
