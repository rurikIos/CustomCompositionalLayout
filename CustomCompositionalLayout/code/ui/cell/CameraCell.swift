//
//  CameraCell.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 10.07.2024.
//

import UIKit
import PinLayout

final class CameraCell: UICollectionViewCell {
    
    private struct Constants {
        static let width: CGFloat = 100
        static let height: CGFloat = 50
    }
    
    private let previewImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [previewImageView, nameLabel].forEach { contentView.addSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: CameraCellViewModel) {
        previewImageView.image = UIImage(named: model.preview)
        nameLabel.text = model.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        let height = previewImageView.frame.height
        let width = previewImageView.frame.width
        return CGSize(width: width, height: height)
    }
    
    private func layout() {
        previewImageView.pin
            .topLeft()
            .width(Constants.width)
            .height(Constants.height)
        
        nameLabel.pin
            .center()
    }
    
}
