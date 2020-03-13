//
//  TopicsFilterNodeCell.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/13/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

class TopicsFilterNodeCell: UICollectionViewCell {
    fileprivate lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    fileprivate lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 14)
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var normalImage: UIImage?
    var selectedImage: UIImage?
    var title: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? NAVBAR_TINT_COLOR : PRIMARY_COLOR
            imageView.image = isSelected ? selectedImage : normalImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
