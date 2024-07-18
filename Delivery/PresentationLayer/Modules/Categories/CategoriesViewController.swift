//
//  CategoriesViewController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit
import Combine


enum Section {
    case main
}

public class CategoriesViewController: UIViewController, CategoriesViewControllerProtocol {
    public var viewModel: CategoriesViewModelProtocol
    private let imageLoader: ImageLoaderProtocol = ImageLoader()

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Category>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Category>

    private lazy var dataSource = makeDataSource()
    private lazy var searchController: SearchController = SearchController()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }()

    private var cancellables = Set<AnyCancellable>()

    public init(viewModel: CategoriesViewModelProtocol) {
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
        viewModel.fetchCategories()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.updateAppearance()
    }

    private func bindViews() {
        viewModel.categories.$value
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.applySnapshot(categories: categories, animatingDifferences: true)
            }
            .store(in: &cancellables)
    }

    // MARK: - Config view

    private func setupViews() {
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

    private func configureNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.updateAppearance()
    }

    private func configureCollectionView() {
        configLayout()
        applySnapshot(categories: viewModel.categories.value)
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, category in
            let defCell = UICollectionViewCell()
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CategoryCollectionViewCell else { return defCell }
            cell.configure(category: category, using: self.imageLoader)
            return cell
        }

        return dataSource
    }

    private func configLayout() {
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.cellIdentifier
        )

        let spaceBetweenItems: CGFloat = 20
        let spaceSectionInset: CGFloat = 20
        let screenWidth = (view.window?.screen.bounds.width ?? view.bounds.width) - spaceBetweenItems

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = screenWidth / 2 - spaceBetweenItems
        let itemHeight: CGFloat = itemWidth * 1.264

        layout.itemSize = .init(width: itemWidth, height: itemHeight)
        layout.sectionInset = .init(
            top: spaceSectionInset,
            left: spaceSectionInset,
            bottom: spaceSectionInset,
            right: spaceSectionInset
        )
        layout.minimumInteritemSpacing = spaceBetweenItems
        layout.minimumLineSpacing = spaceBetweenItems
        layout.scrollDirection = .vertical

        collectionView.collectionViewLayout = layout
    }

    private func applySnapshot(categories: [Category], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCategory(id: viewModel.categories.value[indexPath.row].id)
    }
}

extension CategoriesViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchedText.value = searchController.searchBar.text ?? ""
    }
}
