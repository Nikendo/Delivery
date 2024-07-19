//
//  CategoryViewController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import UIKit
import Combine


public final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    private enum Section: Int {
        case tags
        case products
    }

    private enum Item: Hashable {
        case tag(FilterItem)
        case product(Product)
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

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
        configureNavigationBar()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.updateAppearance()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNavBarImage()
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == Section.tags.rawValue else { return }
        viewModel.selectTag(id: viewModel.tags.value[indexPath.row].id)
    }
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
        configureSearchBar()
        configureCollectionView()
        bindViews()
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        configureNavBarImage()
    }

    func configureNavBarImage() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.backgroundImageContentMode = .bottomRight
        navBarAppearance.backgroundImage = UIImage(resource: .navImgVegetables1)

        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
    }

    func removeNavBarImage() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundImage = nil

        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
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
        applySnapshot(tags: viewModel.tags.value, products: viewModel.products.value)
    }

    func configureLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard sectionIndex == 0 else {
                return self.createProductsSection()
            }
            return self.createTagsSection()
        }
    }

    func createTagsSection() -> NSCollectionLayoutSection {
        collectionView.register(
            FilterViewCell.self,
            forCellWithReuseIdentifier: FilterViewCell.cellIdentifier
        )

        // a tag
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(200),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // horizontal tags group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .absolute(34)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        // tags section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)

        return section
    }

    func createProductsSection() -> NSCollectionLayoutSection {
        collectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.cellIdentifier
        )

        // a product
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(160.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // vertical products group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        // products section
        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    private func configureDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { [weak viewModel] collectionView, indexPath, item in
            let defCell = UICollectionViewCell()

            switch Section(rawValue: indexPath.section) {
            case .tags:
                guard
                    case let .tag(tag) = item,
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FilterViewCell.cellIdentifier,
                        for: indexPath
                    ) as? FilterViewCell
                else { return defCell }

                cell.configure(tag)
                return cell
            case .products:
                guard
                    case let .product(product) = item,
                    let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as? ProductCollectionViewCell
                else { return defCell }
                cell.configure(
                    product: product,
                    using: self.imageLoader,
                    delegate: self
                )
                return cell
            case .none:
                return defCell
            }
        }
    }

    func applySnapshot(tags: [FilterItem], products: [Product], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.tags, .products])
        snapshot.appendItems(tags.map { .tag($0) }, toSection: .tags)
        snapshot.appendItems(products.map { .product($0) }, toSection: .products)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func bindViews() {
        viewModel.products.$value.combineLatest(viewModel.tags.$value)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products, tags in
                self?.applySnapshot(tags: tags, products: products, animatingDifferences: true)
            }
            .store(in: &cancellables)
    }
}

extension CategoryViewController: ProductCollectionViewCellDelegate {
    public func addToFavorite(id: String) {
        viewModel.addToFavorite(id: id)
    }
    
    public func addToCart(id: String) {
        viewModel.addToCart(id: id)
    }
}
