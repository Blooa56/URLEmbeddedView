//
//  URLImageView.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/07.
//
//

import UIKit

protocol URLImageViewProtocol: class {
    func updateActivityView(isHidden: Bool)
    func updateImage(_ image: UIImage?)
}

final class URLImageView: UIImageView {

    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private lazy var presenter = URLImageViewPresenter(view: self)

    var activityViewHidden: Bool = false
    var shouldContinueDownloadingWhenCancel: Bool {
        set { presenter.shouldContinueDownloadingWhenCancel = newValue }
        get { return presenter.shouldContinueDownloadingWhenCancel }
    }

    init() {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        _ = presenter
        activityView.hidesWhenStopped = true
        addSubview(activityView)
        addConstraints(with: activityView, size: .init(width: 30, height: 30))
        addConstraints(with: activityView, center: .zero)
    }
    
    func loadImage(urlString: String, completion: ((Result<UIImage>) -> Void)? = nil) {
        presenter.loadImage(urlString: urlString, completion: completion)
    }

    func cancelLoadingImage() {
        presenter.cancelLoadingImage()
    }
}

extension URLImageView: URLImageViewProtocol {
    func updateActivityView(isHidden: Bool) {
        activityView.isHidden = isHidden
        if isHidden {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }

    func updateImage(_ image: UIImage?) {
        self.image = image
    }
}

