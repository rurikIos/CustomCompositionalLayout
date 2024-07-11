//
//  MainViewController.swift
//  CustomCompositionalLayout
//
//  Created by Чайков Ю.И. on 09.07.2024.
//

import UIKit
import PinLayout

protocol MainView: BaseView where AssociatedState == MainState {}

final class MainViewController: UIViewController, MainView {
    
    private let intent: MainIntent
    
    private var models: [[CellViewModel]] = [[]]
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            self?.createSectionLayout(for: sectionIndex)
        }
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    init(intent: MainIntent) {
        self.intent = intent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        intent.bind(to: self)
        intent.onViewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    func update(with state: MainState) {
        models = state.models
        collectionView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: "CameraCell")
        collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: "BoxOfficeCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: "EmployeeCell")
        collectionView.register(SaleCell.self, forCellWithReuseIdentifier: "SaleCell")
    }
    
    private func layout() {
        collectionView.pin.all()
    }
    
    private func createSectionLayout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: createGroupLayout())
        return section
    }
    
    private func createGroupLayout() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Dimens.inlineHeight_default)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [])
        
        let fullWidthGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Dimens.inlineHeight_default)
        )
        let halfWidthGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(Dimens.inlineHeight_default)
        )
        
        // кассы
        let boxOfficeGroupLayout = NSCollectionLayoutGroup.vertical(layoutSize: fullWidthGroupSize, subitems: [item])
        // товары
        let productsGroupLayout = NSCollectionLayoutGroup.vertical(layoutSize: fullWidthGroupSize, repeatingSubitem: item, count: 9)
        // левый столбец
        let groupLayout0 = NSCollectionLayoutGroup.vertical(
            layoutSize: halfWidthGroupSize,
            subitems: [boxOfficeGroupLayout, productsGroupLayout]
        )
        
        // сотрудники
        let employeeGroupLayout = NSCollectionLayoutGroup.vertical(layoutSize: fullWidthGroupSize, repeatingSubitem: item, count: 4)
        // продажи
        let saleGroupLayout = NSCollectionLayoutGroup.vertical(layoutSize: fullWidthGroupSize, repeatingSubitem: item, count: 5)
        let groupLayout1 = NSCollectionLayoutGroup.vertical(
            layoutSize: halfWidthGroupSize, 
            subitems: [employeeGroupLayout, saleGroupLayout]
        )
        
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: fullWidthGroupSize, subitems: [groupLayout0, groupLayout1])
        
        return groupLayout
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = models[indexPath.section][indexPath.item]
        switch item {
        case .camera(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CameraCell",
                for: indexPath
            ) as! CameraCell
            cell.setup(model)
            return cell
        case .boxOffice(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "BoxOfficeCell",
                for: indexPath
            ) as! BoxOfficeCell
            cell.setup(model)
            return cell
        case .product(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProductCell",
                for: indexPath
            ) as! ProductCell
            cell.setup(model)
            return cell
        case .employee(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "EmployeeCell",
                for: indexPath
            ) as! EmployeeCell
            cell.setup(model)
            return cell
        case .sale(let model):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SaleCell",
                for: indexPath
            ) as! SaleCell
            cell.setup(model)
            return cell
        }
    }
}
