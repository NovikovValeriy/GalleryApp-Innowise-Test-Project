//
//  FeedPhotosViewController.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 28.09.25.
//

import UIKit
import CHTCollectionViewWaterfallLayout

struct FeedPhotosValues {
    static let narrowColumnsCount: Int = 2
    static let extendedColumnsCount: Int = 4
    static let columnSpacing: CGFloat = 5
    static let interitemSpacing: CGFloat = 5
}

class FeedPhotosViewController: UIViewController {
    
    typealias PWCVCValues = PhotosWaterfallCollectionViewCellValues
    typealias FPValues = FeedPhotosValues
    
    private var dataSource: UICollectionViewDiffableDataSource<GAWaterfallCollectionViewSections, Photo>!
    private let viewModel: FeedPhotosViewModel

    // MARK: - UI elements
    
    private let photosWaterfallView: GAPhotosWaterfallView = {
        let view = GAPhotosWaterfallView()
        view.itemRenderDirection = .shortestFirst
        view.columnSpacing = FPValues.columnSpacing
        view.interitemSpacing = FPValues.interitemSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Configuration
    
    private func photosWaterfallViewConfiguration() {
        photosWaterfallView.delegate = self
        
        view.addSubview(photosWaterfallView)
        
        
        NSLayoutConstraint.activate([
            photosWaterfallView.topAnchor.constraint(equalTo: view.topAnchor),
            photosWaterfallView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photosWaterfallView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photosWaterfallView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        dataSource = configureDiffableDataSource()
    }
    
    private func navigationBarConfiguration() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Feed photos"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureUI() {
        self.photosWaterfallViewConfiguration()
        self.navigationBarConfiguration()
    }
    
    private func bindViewModel() {
        self.viewModel.onFeedPhotosUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateDatasource()
            }
        }
        
        self.viewModel.onSavedPhotosUpdated = { [weak self] in
            DispatchQueue.main.async {
                guard let cellsToCheck = (self?.photosWaterfallView.collectionView.visibleCells as? [PhotosWaterfallCollectionViewCell]) else { return }
                for cell in cellsToCheck {
                    guard let photo = cell.photo else { continue }
                    let markedAsSaved = self?.viewModel.savedPhotos.firstIndex(of: photo) != nil
                    cell.showSavedIcon(markedAsSaved)
                }
            }
        }
    }
    
    // MARK: - Data source
    
    private func configureDiffableDataSource() -> UICollectionViewDiffableDataSource<GAWaterfallCollectionViewSections, Photo> {
        return UICollectionViewDiffableDataSource(
            collectionView: self.photosWaterfallView.collectionView,
            cellProvider: { [weak self] collectionView, indexPath, model in
            guard let self = self,
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosWaterfallCollectionViewCell.identifier, for: indexPath) as? PhotosWaterfallCollectionViewCell else {
                return PhotosWaterfallCollectionViewCell()
            }
            
            let photo = self.viewModel.photos[indexPath.row]
            
            if cell.hasViewModel {
                cell.configure(photo: photo, index: indexPath.row)
            } else {
                guard let vm: PhotosWaterfallCollectionViewCellViewModel = try? DependenciesContainer.shared.inject() else {
                    return PhotosWaterfallCollectionViewCell()
                }
                vm.onPhotoPressed = self.viewModel.onPhotoPressed
                cell.configure(with: vm, photo: photo, index: indexPath.row)
            }
            
            let markedAsSaved = self.viewModel.savedPhotos.firstIndex(of: photo) != nil
            cell.showSavedIcon(markedAsSaved)
                
            return cell
        })
    }
    
    private func updateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<GAWaterfallCollectionViewSections, Photo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.photos)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
        dataSource = self.configureDiffableDataSource()
        
        self.viewModel.getFeedPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.viewModel.getSavedPhotos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    init(viewModel: FeedPhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Delegate conformance

// Waterfall layout delegate
extension FeedPhotosViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? CHTCollectionViewWaterfallLayout else {
            return CGSize(width: 0, height: 0)
        }
        
        let photo = self.viewModel.photos[indexPath.row]
        var imageHeight = CGFloat(photo.height ?? 100)
        var imageWidth = CGFloat(photo.width ?? 100)
        
        let viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.size.width
        let columnCount = CGFloat(layout.columnCount)
        
        let estimatedImageWidth = (viewWidth / columnCount) - FPValues.columnSpacing * (columnCount - 1)
        
        imageHeight = imageHeight * (estimatedImageWidth / imageWidth)
        imageWidth = estimatedImageWidth
        
        let cellHeight = imageHeight + PWCVCValues.labelFontSize + PWCVCValues.titlePadding * 2
                
        return CGSize(width: imageWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        guard let layout = collectionViewLayout as? CHTCollectionViewWaterfallLayout else {
            return 0
        }
        if self.view.frame.size.width / self.view.frame.size.height > 2  {
            layout.columnCount = FPValues.extendedColumnsCount
        } else {
            layout.columnCount = FPValues.narrowColumnsCount
        }
        return layout.columnCount
    }
}

// Collection view delegate
extension FeedPhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= self.viewModel.photos.count - 1 {
            self.viewModel.getFeedPhotos()
        }
    }
}
