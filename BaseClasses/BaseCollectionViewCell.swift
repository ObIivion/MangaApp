//
//  BaseCollectionViewCell.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        awakeFromNib()
        self.initSetup()
    }
    
    func initSetup(){
        
    }
    
}

