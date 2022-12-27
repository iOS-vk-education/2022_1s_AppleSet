//
//  NetworkCell.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import UIKit
import PinLayout


final class NetworkCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let lockImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        lockImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(lockImageView)
    }
    
    func configure(with model: WiFiModel) {
        nameLabel.text = model.ssid
        nameLabel.font = UIFont(name: "Menlo-Bold", size: 20)
        lockImageView.image = model.isOpen ? UIImage(systemName: "lock.fill") : nil
        lockImageView.tintColor = .systemGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.pin
            .vCenter()
            .sizeToFit(.height)
            .left(12)
            .height(32)
        
        lockImageView.pin
            .size(CGSize(width: 24, height: 24))
            .vCenter()
            .right(12)
    }
}


