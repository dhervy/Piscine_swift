//
//  SecondViewController.swift
//  D03
//
//  Created by Duane HERVY on 1/11/19.
//  Copyright © 2019 Duane HERVY. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView: UIImageView?
    var image: UIImage? {
        didSet {
            imageView = UIImageView(image: image)
        }
    }
    var imageURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageVi = imageView {
            self.navigationItem.title = "Aperçu"
            scrollView.addSubview(imageVi)
            scrollView.contentSize = (imageVi.frame.size)
            let imageViewSize = self.imageView?.bounds.size
            let scrollViewSize = scrollView.bounds.size
            let widthScale = scrollViewSize.width / (imageViewSize?.width)!
            let heightScale = scrollViewSize.height / (imageViewSize?.height)!
            scrollView.minimumZoomScale = min(widthScale, heightScale)
            scrollView.zoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
