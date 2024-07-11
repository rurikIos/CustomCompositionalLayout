//
//  MainState.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 11.07.2024.
//

struct MainState: BaseState {
    
    static var initialState = MainState(models: [])
    
    let models: [[CellViewModel]]
    
    func modified(models: [[CellViewModel]]) -> MainState {
        MainState(models: models)
    }
}
