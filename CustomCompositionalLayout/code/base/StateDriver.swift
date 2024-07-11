//
//  StateDriver.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 11.07.2024.
//

import Combine
import Foundation

final class StateDriver<S: BaseState> {
    
    private let subject = CurrentValueSubject<S, Never>(.initialState)
    
    private var cancellable = Set<AnyCancellable>()
    
    var value: S {
        subject.value
    }
    
    func accept(_ event: S) {
        subject.value = event
    }
    
    func bind<V: BaseView>(to view: V) where V.AssociatedState == S {
        subject
            .receive(on: DispatchQueue.main)
            .sink { [weak view] state in
                view?.update(with: state)
            }
            .store(in: &cancellable)
    }
}
