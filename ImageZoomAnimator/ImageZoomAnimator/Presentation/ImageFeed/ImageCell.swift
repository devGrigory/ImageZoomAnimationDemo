//
//  ImageCell.swift
//  ImageZoomAnimator
//
//  Created by Grigory G. on 28.07.23.
//

import UIKit

final class ImageCell: UITableViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 8
        
        static let id = "ImageCell"
    }
    
    // MARK: - Properties
    static let reuseId = Constants.id
    
    weak var delegate: ImageCellDelegate?
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.backgroundColor = .systemGray6
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureAppearance()
        setupHierarchy()
        setupLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configureAppearance() {
        backgroundColor = .black
        selectionStyle = .none
    }
    
    // MARK: - View Hierarchy
    private func setupHierarchy() {
        contentView.addSubview(photoImageView)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding)
        ])
    }
}

// MARK: - Gestures
private extension ImageCell {
    func setupGestures() {
        let pinchGesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinch(_:))
        )
        photoImageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc
    func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        delegate?.imageCellDidPinch(photoImageView, gesture: gesture)
    }
}
