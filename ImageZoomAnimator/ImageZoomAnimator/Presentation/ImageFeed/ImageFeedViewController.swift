//
//  ImageFeedViewController.swift
//  ImageZoomAnimator
//
//  Created by Grigory G. on 28.07.23.
//

import UIKit

// MARK: - ImageCellDelegate
protocol ImageCellDelegate: AnyObject {
    func imageCellDidPinch(
        _ imageView: UIImageView,
        gesture: UIPinchGestureRecognizer
    )
}

// MARK: - ImageFeedViewController
final class ImageFeedViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let title = "Image Feed"
        static let rowHeight: CGFloat = 280
    }
    
    // MARK: - Dependencies
    private let zoomAnimator: ImageZoomAnimating
    private let imageProvider: ImageFeedProviding
    
    // MARK: - State
    private var items: [ImageItem] = []
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = Constants.rowHeight
        tableView.backgroundColor = .black
        return tableView
    }()
    
    // MARK: - Initialization
    init(zoomAnimator: ImageZoomAnimating,
         imageProvider: ImageFeedProviding
    ) {
        /// Dependency Injection
        self.zoomAnimator = zoomAnimator
        self.imageProvider = imageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        items = imageProvider.fetchImages()
        
        configureAppearance()
        setupHierarchy()
        setupLayout()
        configureTableView()
    }
    
    // MARK: - Setup
    private func configureAppearance() {
        title = Constants.title
        view.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        
        tableView.register(
            ImageCell.self,
            forCellReuseIdentifier: ImageCell.reuseId
        )
    }
}

// MARK: - UITableViewDataSource
extension ImageFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ImageCell.reuseId,
            for: indexPath
        ) as! ImageCell
        
        cell.photoImageView.image = UIImage(named: items[indexPath.row].imageName)
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: - ImageCellDelegate
extension ImageFeedViewController: ImageCellDelegate {
    
    func imageCellDidPinch(
        _ imageView: UIImageView,
        gesture: UIPinchGestureRecognizer
    ) {
        zoomAnimator.handlePinch(
            gesture: gesture,
            from: imageView,
            in: view
        )
    }
}
