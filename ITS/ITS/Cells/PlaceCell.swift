//
//  PlaceCell.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit
import PinLayout

final class PlaceCell: UICollectionViewCell {

    private let nameLabel: UILabel = UILabel()
    
    private var model: PlaceCellModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setup() {
        backgroundColor = Constants.customBlue
        layer.cornerRadius = Constants.PlaceCell.cornerRadius
        clipsToBounds = true
        
        nameLabel.font = Constants.PlaceCell.nameLabelFont
        
        addSubview(nameLabel)
    }
    
    func configure(with model: PlaceCellModel) {
        self.model = model
        nameLabel.text = model.name
        nameLabel.textColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.pin
            .centerLeft(13)
            .right(13)
            .sizeToFit(.width)
    }
}

// MARK: - Static values

private extension PlaceCell {
    struct Constants {
        static let customBlue = UIColor(red: 0x27 / 255,
                                        green: 0x4c / 255,
                                        blue: 0x77 / 255,
                                        alpha: 1)
        
        struct PlaceCell {
            static let cornerRadius: CGFloat = 13
            static let nameLabelFont: UIFont = UIFont(name: "Menlo-Bold", size: 17)!
        }
    }
}
