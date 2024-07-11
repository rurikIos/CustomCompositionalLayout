//
//  BaseView.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 11.07.2024.
//

protocol BaseView: AnyObject {
    associatedtype AssociatedState: BaseState
    func update(with state: AssociatedState)
}
