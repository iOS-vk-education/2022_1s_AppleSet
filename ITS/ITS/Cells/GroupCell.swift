//
//  PlaceCell.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit
import PinLayout

final class GroupCell: UICollectionViewCell {

    private let nameLabel: UILabel = UILabel()
    
    private var model: GroupCellModel?
    
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
        backgroundColor = .customBlue
        layer.cornerRadius = Constants.GroupCell.cornerRadius
        clipsToBounds = true
        
        nameLabel.font = Constants.GroupCell.nameLabelFont
        
        addSubview(nameLabel)
    }
    
    func configure(with model: GroupCellModel) {
        self.model = model
        nameLabel.text = model.name
        nameLabel.textColor = .black
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

private extension GroupCell {
    struct Constants {
        
        struct GroupCell {
            static let cornerRadius: CGFloat = 13
            static let nameLabelFont: UIFont = UIFont(name: "Menlo-Bold", size: 17)!
        }
    }
}
