//
//  AdvancedViewController.swift
//  Something
//
//  Created by Veronika Andrianova on 25.01.2022.
//

import Foundation
import UIKit

class AdvancedViewController: UIViewController {

    enum SectionKind: Int, CaseIterable {
        case list,
             grid
        var columnCount: Int {
            switch self {
            case .list:
                return 2
            case .grid:
                return 3
            }
        }
    }
    var dateSource: UICollectionViewDiffableDataSource<SectionKind , Int>!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
  
        collectionView.register(UserCell .self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(FoodCell .self, forCellWithReuseIdentifier: FoodCell.reuseId)
        
        setupDataSource()
        reloadData()
    }
    
    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Error \(cellType)")
        }
        return cell
    }
    
    private func setupDataSource() {
        dateSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { ( collectionView, indexPath, intValue) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
            case .list:
                return self.configure(cellType: UserCell.self, with: intValue, for: indexPath)
            case .grid:
                return self.configure(cellType: FoodCell.self, with: intValue, for: indexPath)
            }
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        let itemPerSection = 10
        SectionKind.allCases.forEach { (sectionKind) in
            let itemOffset = sectionKind.columnCount * itemPerSection
            let itemUpperbound = itemOffset + itemPerSection
            snapshot.appendSections([sectionKind])
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        dateSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

        return section
    }
    
    private func createLayoutGrid() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
                                                     heightDimension: .estimated(88))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 12, bottom: 0, trailing: 12)
        
        return layoutSection
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            let section = SectionKind(rawValue: sectionIndex)!
            switch section {
            case .list:
                return self.createLayoutSection()
            case .grid:
                return self.createLayoutGrid()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 100
        layout.configuration = config
        
        return layout
    }
}

// MARK: - SwiftUI
import SwiftUI
struct AdvancedProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let tabBar = MainTabBarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<AdvancedProvider.ContainterView>) -> MainTabBarController {
            return tabBar
        }
        
        func updateUIViewController(_ uiViewController: AdvancedProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<AdvancedProvider.ContainterView>) {
            
        }
    }
}
