//
//  CellViewModel.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 09.07.2024.
//

enum CellViewModel {
    case camera(CameraCellViewModel)
    case boxOffice(BoxOfficeCellViewModel)
    case product(ProductCellViewModel)
    case employee(EmployeeCellViewModel)
    case sale(SaleCellViewModel)
}
