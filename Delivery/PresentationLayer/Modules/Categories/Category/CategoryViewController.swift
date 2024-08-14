//
//  CategoryViewController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import UIKit
import Combine


public final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    private enum Section {
        case products
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Product>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Product>

    public var viewModel: CategoryViewModelProtocol

    private let imageLoader: ImageLoaderProtocol = ImageLoader()
    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource: DataSource = configureDataSource()
    private lazy var searchController: SearchController = SearchController()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()

    init(viewModel: CategoryViewModelProtocol) {
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
    }

    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        viewModel.fetchProducts()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.updateAppearance()
    }
}

extension CategoryViewController: UICollectionViewDelegate {

}

extension CategoryViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchedText.value = searchController.searchBar.text ?? ""
    }
}

private extension CategoryViewController {
    func setupViews() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        configureNavigationTitle()
        configureSearchBar()
        configureCollectionView()
        bindViews()
    }

    func configureNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.updateAppearance()
    }

    func configureCollectionView() {
        configureLayout()
        applySnapshot(products: viewModel.products.value)
    }

    func configureLayout() {
        collectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.cellIdentifier
        )

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(160.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }

    private func configureDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, product in
            let defCell = UICollectionViewCell()
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? ProductCollectionViewCell else { return defCell }
            cell.configure(
                product: product,
                using: self.imageLoader,
                favoriteActionHandler: { _ in

                },
                cartActionHandler: { _ in

                }
            )
            return cell
        }
    }

    func applySnapshot(products: [Product], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.products])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func bindViews() {
        viewModel.products.$value
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.applySnapshot(products: products, animatingDifferences: true)
            }
            .store(in: &cancellables)
    }
}
