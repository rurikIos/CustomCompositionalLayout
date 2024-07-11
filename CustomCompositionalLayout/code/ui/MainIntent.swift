//
//  MainIntent.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 11.07.2024.
//

protocol MainIntentProtocol: AnyObject {
    func bind<V: MainView>(to view: V)
    func onViewDidLoad()
}

final class MainIntent: MainIntentProtocol {
    
    private let stateDriver = StateDriver<MainState>()
    
    private var models: [[CellViewModel]] {
        [boxOffice + product + employee + sale]
    }
    
    private var boxOffice: [CellViewModel] = [
        .boxOffice(BoxOfficeCellViewModel(count: "23"))
    ]
    
    private var product: [CellViewModel] = [
        .product(ProductCellViewModel(name: "Белая спаржа", count: "23", cost: "15683")),
        .product(ProductCellViewModel(name: "Греча отварная (150г)", count: "234", cost: "3768")),
        .product(ProductCellViewModel(name: "Круассан", count: "123", cost: "23675")),
        .product(ProductCellViewModel(name: "Семга, 350 гр.", count: "123", cost: "23675")),
        .product(ProductCellViewModel(name: "Вареный картофель", count: "65", cost: "19471")),
        .product(ProductCellViewModel(name: "Салат, зелень", count: "24", cost: "9471")),
        .product(ProductCellViewModel(name: "Белая спаржа", count: "23", cost: "15683")),
        .product(ProductCellViewModel(name: "Греча отварная (150г)", count: "234", cost: "3768")),
        .product(ProductCellViewModel(name: "Круассан", count: "123", cost: "23675"))
    ]
    
    private var employee: [CellViewModel] = [
        .employee(EmployeeCellViewModel(photo: "employee1", name: "Юлия Петухова", checkNumber: "134", cost: "112337")),
        .employee(EmployeeCellViewModel(photo: "employee2", name: "Леон Дементьев", checkNumber: "21", cost: "12583")),
        .employee(EmployeeCellViewModel(photo: "employee3", name: "Екатерина Рубен", checkNumber: "21", cost: "5599")),
        .employee(EmployeeCellViewModel(photo: "employee2", name: "Леон Дементьев", checkNumber: "11", cost: "3231"))
    ]
    
    private var sale: [CellViewModel] = [
        .sale(SaleCellViewModel(date: "27.09", day: "пн", count: "3560", cost: "3253")),
        .sale(SaleCellViewModel(date: "26.09", day: "вс", count: "1556", cost: "1979")),
        .sale(SaleCellViewModel(date: "25.09", day: "сб", count: "1610", cost: "2255")),
        .sale(SaleCellViewModel(date: "24.09", day: "пт", count: "2610", cost: "5812")),
        .sale(SaleCellViewModel(date: "23.09", day: "чт", count: "1605", cost: "5763"))
    ]
    
    func bind<V>(to view: V) where V : MainView {
        stateDriver.bind(to: view)
    }
    
    func onViewDidLoad() {
        stateDriver.accept(stateDriver.value.modified(models: models))
    }
}
