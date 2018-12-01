//
//  StudentCollectionViewCell.swift
//  Registration
//
//  Created by MIT App Dev on 11/30/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var studendView: UIView!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        studendView.layer.cornerRadius = 6
        studendView.layer.masksToBounds = true
    }
}
