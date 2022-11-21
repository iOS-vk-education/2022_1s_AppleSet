//
//  DeviceCell.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit
import PinLayout


final class DeviceCell: UICollectionViewCell {

    private let nameLabel: UILabel = UILabel()
    private let values: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
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
        backgroundColor = .white
        layer.cornerRadius = Constants.DeviceCell.cornerRadius
        clipsToBounds = true
        
        nameLabel.font = UIFont(name: "Menlo-Bold", size: 18)
        values.font = UIFont(name: "Menlo-Bold", size: 16)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(nameLabel)
        addSubview(values)
        addSubview(imageView)
    }
    
    func configure(with model: DeviceCellModel) {
        self.model = model
        
        nameLabel.text = model.name
        imageView.image = model.image
        values.text = model.values
        nameLabel.textColor = Constants.customBlue
        values.textColor = Constants.customBlue
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        nameLabel.pin
            .topLeft(18)
            .right(10)
            .sizeToFit(.width)

        values.pin
            .below(of: nameLabel)
            .topLeft(18)
            .marginTop(16)
            .horizontally(10)
            .sizeToFit(.width)
        
        imageView.pin
            .below(of: values)
            .center()
            .marginTop(16)
            .above(of: values)
            .marginBottom(10)
            .horizontally()
        
      
    }
       

    
}

// MARK: - Static values

private extension DeviceCell {
    struct Constants {
        static let customBlue = UIColor(red: 0x27 / 255,
                                        green: 0x4c / 255,
                                        blue: 0x77 / 255,
                                        alpha: 1)
        
        struct DeviceCell {
            static let cornerRadius: CGFloat = 13
            static let nameLabelFont: UIFont = UIFont(name: "Menlo-Bold", size: 17)!
        }
    }
}
