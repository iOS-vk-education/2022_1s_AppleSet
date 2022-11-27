//
//  DeviceCell.swift
//  ITS
//
//  Created by Natalia on 26.11.2022.
//

import UIKit
import PinLayout

final class DeviceCell: UICollectionViewCell {

    private let nameLabel: UILabel = UILabel()
    
    private var model: DeviceCellModel?
    
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
        layer.cornerRadius = Constants.DeviceCell.cornerRadius
        clipsToBounds = true
        
      
        
        nameLabel.font = Constants.DeviceCell.nameLabelFont
        
        addSubview(nameLabel)
    }
    
    func configure(with model: DeviceCellModel) {
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

private extension DeviceCell {
    struct Constants {
        
        struct DeviceCell {
            static let cornerRadius: CGFloat = 13
            static let nameLabelFont: UIFont = UIFont(name: "Menlo-Bold", size: 17)!
        }
    }
}
