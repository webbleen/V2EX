//
//  TopicsFilterNodeSectionHeaderView.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/13/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

class TopicsFilterNodeSectionHeaderView: UICollectionReusableView {
    
    fileprivate lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = PRIMARY_COLOR
        return view
    }()
    
    var title: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
