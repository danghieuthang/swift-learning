//
//  BaseCollectionViewCell.swift
//  learning
//
//  Created by Thắng Đặng on 5/29/24.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var subTitleLabel: UILabel!
    
    func configureLabels(with model: BaseModel?) {
        nameLabel.text = model?.title
        subTitleLabel.text = model?.description
    }
}
