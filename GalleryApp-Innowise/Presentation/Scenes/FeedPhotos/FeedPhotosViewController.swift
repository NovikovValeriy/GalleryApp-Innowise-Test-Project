//
//  FeedPhotosViewController.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 28.09.25.
//

import UIKit
import CHTCollectionViewWaterfallLayout

enum WaterfallCollectionViewSections {
    case main
}

class FeedPhotosViewController: UIViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<WaterfallCollectionViewSections, Photo>!
    private let viewModel: FeedPhotosViewModel

    // MARK: - UI elements
    
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .shortestFirst
        layout.minimumColumnSpacing = 0
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosWaterfallCollectionViewCell.self, forCellWithReuseIdentifier: PhotosWaterfallCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - UI Configuration
    
    private func collectionViewConfiguration() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureUI() {
        self.collectionViewConfiguration()
    }
    
    private func bindViewModel() {
        self.viewModel.onFeedPhotosUpdated = { [weak self] in
            print(self?.viewModel.photos ?? [])
        }
    }
    
    // MARK: - Data source
    
    private func configureDiffableDataSource() -> UICollectionViewDiffableDataSource<WaterfallCollectionViewSections, Photo> {
        return UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosWaterfallCollectionViewCell.identifier, for: indexPath) as? PhotosWaterfallCollectionViewCell else {
                return PhotosWaterfallCollectionViewCell()
            }
            return cell
        })
    }
    
    private func updateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<WaterfallCollectionViewSections, Photo>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
        
        self.viewModel.getFeedPhotos()
    }
    
    init(viewModel: FeedPhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
