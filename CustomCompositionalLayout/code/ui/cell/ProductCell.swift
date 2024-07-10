//
//  ProductCell.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 10.07.2024.
//

import UIKit
import PinLayout

final class ProductCell: UICollectionViewCell {
    
    private struct Constants {
        static let costWidth: CGFloat = 50
    }
    
    private let nameLabel = UILabel()
    private let countLabel = UILabel()
    private let costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [nameLabel, countLabel, costLabel].forEach { contentView.addSubview($0) }
        contentView.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: ProductCellViewModel) {
        nameLabel.text = model.name
        countLabel.text = model.count
        costLabel.text = model.cost
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        return size
    }
    
    private func layout() {
        costLabel.pin
            .topRight(Dimens.offset_m)
            .maxWidth(Constants.costWidth)
            .sizeToFit(.width)
        
        countLabel.pin
            .top(Dimens.offset_m)
            .right(Constants.costWidth + Dimens.offset_m)
            .sizeToFit()
        
        nameLabel.pin
            .top(Dimens.offset_m)
            .left(Dimens.offset_m)
            .left(of: countLabel)
            .sizeToFit(.width)
    }
    
}
