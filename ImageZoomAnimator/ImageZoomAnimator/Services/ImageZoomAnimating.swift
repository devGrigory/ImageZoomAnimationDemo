//
//  ImageZoomAnimating.swift
//  ImageZoomAnimator
//
//  Created by Grigory G. on 28.07.23.
//

import UIKit

// MARK: - Protocol
protocol ImageZoomAnimating {
    func handlePinch(
        gesture: UIPinchGestureRecognizer,
        from imageView: UIImageView,
        in containerView: UIView
    )
}

// MARK: - Animator
final class ImageZoomAnimator {
    
    // MARK: - Constants
    private enum Constants {
        static let animationDuration: TimeInterval = 0.3
        static let defaultCornerRadius: CGFloat = 12
    }
    
    // MARK: - Properties
    private let zoomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.defaultCornerRadius
        return imageView
    }()
    
    // MARK: - Private Methods
    private func beginZoom(
        from sourceImageView: UIImageView,
        in containerView: UIView
    ) {
        let frame = sourceImageView.convert(sourceImageView.bounds, to: containerView)
        zoomImageView.frame = frame
        zoomImageView.image = sourceImageView.image
        zoomImageView.layer.cornerRadius = sourceImageView.layer.cornerRadius
        
        containerView.addSubview(zoomImageView)
        sourceImageView.alpha = 0
    }
    
    private func endZoom(_ sourceImageView: UIImageView) {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.zoomImageView.transform = .identity
        } completion: { _ in
            self.zoomImageView.removeFromSuperview()
            sourceImageView.alpha = 1
            sourceImageView.transform = .identity
        }
    }
}

// MARK: - ImageZoomAnimating
extension ImageZoomAnimator: ImageZoomAnimating {
    func handlePinch(
        gesture: UIPinchGestureRecognizer,
        from sourceImageView: UIImageView,
        in containerView: UIView
    ) {
        switch gesture.state {
        case .began:
            beginZoom(from: sourceImageView, in: containerView)
        case .changed:
            zoomImageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
        case .ended, .cancelled:
            endZoom(sourceImageView)
        default:
            break
        }
    }
}
