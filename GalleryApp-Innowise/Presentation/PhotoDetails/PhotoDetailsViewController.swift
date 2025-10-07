//
//  PhotoDetailsViewController.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import UIKit

struct PhotoDetailsViewControllerValues {
    static let imageViewCornerRadius: CGFloat = 20
    
    static let buttonBackgroundAlpha: CGFloat = 0.8
    static let buttonPadding: CGFloat = 5
    static let buttonCornerRadius: CGFloat = imageViewCornerRadius - buttonPadding
    static let buttonDimensions: CGFloat = 50
    
    static let authorNameLabelFontSize: CGFloat = 25
    static let authorNameLabelHorizontalPadding: CGFloat = imageViewCornerRadius
    static let authorNameLabelTopPadding: CGFloat = 10
    
    static let descriptionLabelFontSize: CGFloat = 16
    static let descriptionLabelHorizontalPadding: CGFloat = imageViewCornerRadius
    static let descriptionLabelTopPadding: CGFloat = 5
}

final class PhotoDetailsViewController: UIViewController {

    typealias PDVCValues = PhotoDetailsViewControllerValues
    
    private let viewModel: PhotoDetailsViewModel
    
    var photo: Photo? {
        return viewModel.photo
    }
    
    // MARK: - UI Configuration
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = PDVCValues.imageViewCornerRadius
        view.layer.masksToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = .systemBackground.withAlphaComponent(PDVCValues.buttonBackgroundAlpha)
        button.tintColor = .label
        
        button.layer.cornerRadius = PDVCValues.buttonCornerRadius
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .systemBackground.withAlphaComponent(PDVCValues.buttonBackgroundAlpha)
        button.tintColor = .label
        
        button.layer.cornerRadius = PDVCValues.buttonCornerRadius
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: PDVCValues.authorNameLabelFontSize, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: PDVCValues.descriptionLabelFontSize, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureRootView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureContentView() {
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func configureBackgroundImageView() {
        contentView.addSubview(imageBackgroundView)
        imageBackgroundView.backgroundColor = UIColor(hex: self.viewModel.photo?.averageColor ?? "#000000")
        let imageAspectRatio: CGFloat = CGFloat(self.viewModel.photo?.height ?? 100) / CGFloat(self.viewModel.photo?.width ?? 100)
        NSLayoutConstraint.activate([
            imageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBackgroundView.heightAnchor.constraint(equalTo: imageBackgroundView.widthAnchor, multiplier: imageAspectRatio),
        ])
    }
    
    private func configureImageView() {
        imageBackgroundView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor),
        ])
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: PDVCValues.buttonPadding),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PDVCValues.buttonPadding),
            backButton.heightAnchor.constraint(equalToConstant: PDVCValues.buttonDimensions),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
        ])
    }
    
    private func configureSaveButton() {
        contentView.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.isEnabled = false
        saveButton.isHidden = true
        
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PDVCValues.buttonPadding),
            saveButton.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -PDVCValues.buttonPadding),
            saveButton.heightAnchor.constraint(equalToConstant: PDVCValues.buttonDimensions),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor),
        ])
    }
    
    private func configureDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.text = viewModel.photo?.altDescription
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PDVCValues.descriptionLabelHorizontalPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PDVCValues.descriptionLabelHorizontalPadding),
            descriptionLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: PDVCValues.descriptionLabelTopPadding),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)

        ])
    }
    
    private func configureAuthorNameLabel() {
        contentView.addSubview(authorNameLabel)
        authorNameLabel.text = self.viewModel.photo?.authorName
        NSLayoutConstraint.activate([
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PDVCValues.authorNameLabelHorizontalPadding),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PDVCValues.authorNameLabelHorizontalPadding),
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: PDVCValues.authorNameLabelTopPadding),
        ])
    }
    
    private func updateSaveButtonAppearance(isSaved: Bool) {
        if isSaved {
            let filledHeart = UIImage(systemName: "heart.fill")
            saveButton.setImage(filledHeart, for: .normal)
            saveButton.tintColor = .red
        } else {
            let emptyHeart = UIImage(systemName: "heart")
            saveButton.setImage(emptyHeart, for: .normal)
            saveButton.tintColor = .label
        }
    }
    
    @objc private func backButtonPressed() {
        self.viewModel.onBackButtonPressed?()
    }
    
    @objc private func saveButtonPressed() {
        if self.viewModel.isSaved {
            self.viewModel.deletePhoto()
        } else {
            self.viewModel.savePhoto()
        }
    }
    
    private func configureUI() {
        self.configureScrollView()
        self.configureContentView()
        self.configureRootView()
        self.configureBackgroundImageView()
        self.configureImageView()
        self.configureBackButton()
        self.configureSaveButton()
        self.configureAuthorNameLabel()
        self.configureDescriptionLabel()
    }
    
    private func bindViewModel() {
        self.viewModel.onDownloadPhoto = { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
                self?.imageView.alpha = 0
                UIView.animate(withDuration: 0.1) {
                    self?.imageView.alpha = 1
                }
            }
        }
        
        self.viewModel.onCheckedSaved = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateSaveButtonAppearance(isSaved: self.viewModel.isSaved)
                self.saveButton.isEnabled = true
                self.saveButton.isHidden = false
                self.saveButton.alpha = 0
                UIView.animate(withDuration: 0.1) {
                    self.saveButton.alpha = 1
                }
            }
        }
        
        self.viewModel.onPhotoSaved = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1) {
                    self.updateSaveButtonAppearance(isSaved: self.viewModel.isSaved)
                }
            }
        }
        
        self.viewModel.onPhotoDeleted = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1) {
                    self.updateSaveButtonAppearance(isSaved: self.viewModel.isSaved)
                }
            }
        }
        
        self.viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showErrorAlert(message)
            }
        }
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Lifecycle methods
    
    init(viewModel: PhotoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
        self.viewModel.downloadPhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.checkIsPhotoSaved()
    }
}
