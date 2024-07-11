//
//  SaleCell.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 10.07.2024.
//

import UIKit
import PinLayout

final class SaleCell: UICollectionViewCell {
    
    private struct Constants {
        static let countRightMargin: CGFloat = 200
    }
    
    private let dateLabel = UILabel()
    private let dayLabel = UILabel()
    private let countLabel = UILabel()
    private let costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [dateLabel, dayLabel, countLabel, costLabel].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .blue
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: SaleCellViewModel) {
        dateLabel.text = model.date
        dayLabel.text = model.day
        countLabel.text = model.count
        costLabel.text = model.cost
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        let height = dayLabel.frame.maxY + Dimens.offset_m
        return CGSize(width: size.width, height: height)
    }
    
    func layout() {
        dateLabel.pin
            .topLeft(Dimens.offset_m)
            .sizeToFit()
        
        dayLabel.pin
            .top(Dimens.offset_m)
            .right(of: dateLabel)
            .marginLeft(Dimens.offset_m)
            .sizeToFit()
        
        costLabel.pin
            .top(Dimens.offset_m)
            .right(Dimens.offset_m)
            .sizeToFit()
        
        countLabel.pin
            .top(Dimens.offset_m)
            .right(Constants.countRightMargin)
            .sizeToFit()
    }
}
