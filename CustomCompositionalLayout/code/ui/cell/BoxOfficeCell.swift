//
//  BoxOfficeCell.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 10.07.2024.
//

import UIKit
import PinLayout

final class BoxOfficeCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Кассы"
        return label
    }()
    
    private let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [titleLabel, countLabel].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: BoxOfficeCellViewModel) {
        countLabel.text = model.count
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        let height = titleLabel.frame.maxY + Dimens.offset_m
        return CGSize(width: size.width, height: height)
    }
    
    private func layout() {
        titleLabel.pin
            .topLeft(Dimens.offset_m)
            .sizeToFit()
        
        countLabel.pin
            .top(Dimens.offset_m)
            .right(of: titleLabel)
            .marginLeft(Dimens.offset_m)
            .right(Dimens.offset_m)
            .sizeToFit(.width)
        
        countLabel.pin
            .maxWidth(countLabel.frame.width)
            .sizeToFit()
    }
    
}
