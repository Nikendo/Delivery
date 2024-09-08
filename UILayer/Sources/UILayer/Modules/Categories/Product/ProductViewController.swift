//
//  ProductViewController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import UIKit
import Combine
import DataLayer


public final class ProductViewController: UIViewController, ProductViewControllerProtocol {
    
    public private(set) var viewModel: ProductViewModelProtocol
    private var cancellables: [AnyCancellable] = []
    private let imageLoader: ImageLoaderProtocol = ImageLoader()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // configure the font as an attributed text later
        return label
    }()

    private lazy var averageWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = ._06_BE_77
        return label
    }()

    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private lazy var favoriteButton: ProductButton = {
        let button = ProductButton(style: .shortIcon, color: .white, icon: UIImage(systemName: "heart"))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cartButton: ProductButton = {
        let button = ProductButton(
            style: .longIconTitle,
            color: .green,
            icon: UIImage(systemName: "cart"),
            title: "add to cart".uppercased()
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favoriteButton, cartButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 21
        return stack
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()

    private lazy var imagesCollectionView: UICollectionView = {
        let collectionView = getConfiguredCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var roundedBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 33 / 2
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    public init(viewModel: ProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        bindViews()
    }
}

private extension ProductViewController {

    func setupViews() {

        view.addSubview(scrollView)
        scrollView.addSubview(imagesCollectionView)
        scrollView.addSubview(roundedBackView)
        scrollView.addSubview(pageControl)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(averageWeightLabel)
        scrollView.addSubview(countryLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(buttonsStackView)

        // the width of the reference image is 414
        // the height of the reference image is 358
        // 358 / 414 = 0.864
        let imageViewHeightMultiplier: CGFloat = 0.864

        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor),

            imagesCollectionView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            imagesCollectionView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            imagesCollectionView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: imageViewHeightMultiplier),

            roundedBackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            roundedBackView.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: -33),
            roundedBackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            roundedBackView.heightAnchor.constraint(equalToConstant: 33),

            pageControl.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            pageControl.bottomAnchor.constraint(equalTo: roundedBackView.topAnchor, constant: -15),
            pageControl.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),

            nameLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: roundedBackView.topAnchor, constant: 37),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),

            priceLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),

            averageWeightLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            averageWeightLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            averageWeightLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),

            countryLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            countryLabel.topAnchor.constraint(equalTo: averageWeightLabel.bottomAnchor, constant: 32),
            countryLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),

            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),

            favoriteButton.heightAnchor.constraint(equalToConstant: 56),
            cartButton.heightAnchor.constraint(equalToConstant: 56),

            buttonsStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 56),
            buttonsStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -65),
        ])

        favoriteButton.addAction(UIAction(handler: { _ in self.viewModel.addToFavorite() }), for: .touchUpInside)
        cartButton.addAction(UIAction(handler: { _ in self.viewModel.addToCart() }), for: .touchUpInside)
    }

    func configurePrice(price: Double, quantityType: String) {
        let attributedString = NSMutableAttributedString(
            string: price.description,
            attributes: [
                .font: UIFont.systemFont(ofSize: 32, weight: .bold),
                .foregroundColor: UIColor.label
            ]
        )
        attributedString.append(NSAttributedString(
            string: "€ / \(quantityType)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 24, weight: .regular),
                .foregroundColor: UIColor.secondaryLabel
            ]
        ))
        priceLabel.attributedText = attributedString
    }

    func configureWeight(weight: Double, weightUnit: String, quantityType: String) {
        // TODO: Will be implemented later
        averageWeightLabel.text = "~ \(weight.description) \(weightUnit) / \(quantityType)"
    }

    func bindViews() {
        viewModel.product.$value
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.nameLabel.text = $0.name
                self?.configurePrice(price: $0.price, quantityType: $0.quantityType)
                self?.configureWeight(weight: $0.averageWeight, weightUnit: $0.weightUnit, quantityType: $0.quantityType)
                self?.countryLabel.text = $0.country
                self?.descriptionLabel.text = $0.description
                self?.favoriteButton.changeButton(style: .shortIcon, color: .white, icon: UIImage(systemName: $0.isFavorite ? "heart.fill" : "heart"))
                self?.pageControl.numberOfPages = $0.imageUrls.count
                self?.pageControl.currentPage = 0
            }
            .store(in: &cancellables)
    }
}

// MARK: - Images collection view

private extension ProductViewController {

    func getConfiguredCollectionView() -> UICollectionView {
        let aspectRatio: CGFloat = 0.864 // 358 / 414
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.itemSize = CGSize(
            width: view.frame.width,
            height: view.frame.width * aspectRatio
        )

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductImageCollectionViewCell.self, forCellWithReuseIdentifier: ProductImageCollectionViewCell.cellIdentifier)

        return collectionView
    }
}

extension ProductViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.product.value.imageUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductImageCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? ProductImageCollectionViewCell else {
            let defCell = UICollectionViewCell()
            var configuration = UIListContentConfiguration.cell()
            configuration.image = UIImage(resource: .categoryVegetables)
            defCell.contentConfiguration = configuration
            return defCell
        }
        cell.configure(urlString: viewModel.product.value.imageUrls[indexPath.row], loader: imageLoader)

        return cell
    }
}

extension ProductViewController: UICollectionViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
