//
//  EmployeeCell.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 10.07.2024.
//

import UIKit
import PinLayout

final class EmployeeCell: UICollectionViewCell {
    
    private struct Constants {
        static let photoSide: CGFloat = 50
        static let checkNumberRightMargin: CGFloat = 100
    }
    
    private let photoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let checkNumberLabel = UILabel()
    private let costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [photoImageView, nameLabel, checkNumberLabel, costLabel].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: EmployeeCellViewModel) {
        photoImageView.image = UIImage(named: model.photo)
        nameLabel.text = model.name
        checkNumberLabel.text = model.checkNumber
        costLabel.text = model.cost
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        let height = photoImageView.frame.maxY
        return CGSize(width: size.width, height: height)
    }
    
    private func layout() {
        photoImageView.pin
            .topLeft(Dimens.offset_m)
            .width(Constants.photoSide)
            .height(Constants.photoSide)
        
        nameLabel.pin
            .right(of: photoImageView)
            .marginLeft(Dimens.offset_s)
            .vCenter(to: photoImageView.edge.vCenter)
            .sizeToFit()
        
        costLabel.pin
            .right(Dimens.offset_m)
            .vCenter(to: photoImageView.edge.vCenter)
            .sizeToFit()
        
        checkNumberLabel.pin
            .right(Constants.checkNumberRightMargin)
            .vCenter(to: photoImageView.edge.vCenter)
            .sizeToFit()
    }
}
