//
//  ErrorView.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var retryButton: UIButton!
    
    var error: V2Error? {
        didSet {
            titleLabel.text = error?.title
            messageLabel.text = error?.message
            retryButton.tintColor = PRIMARY_COLOR
            retryButton.setTitle("retry".localized, for: .normal)
        }
    }
}
