//
//  FlowViewController.swift
//  Something
//
//  Created by Veronika Andrianova on 25.01.2022.
//

import Foundation
import UIKit

class FlowViewController: UIViewController {
    
    var collectionView: UICollectionView!
    private var colors: [UIColor] = [
        .systemCyan,
        .systemBlue,
        .systemRed,
        .systemYellow,
        .systemMint,
        .systemPink,
        .systemOrange,
        .systemTeal,
        .systemGreen
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .lightGray
        view.addSubview(collectionView)
  
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(hangLongPressGesture))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func hangLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        let gestureLocation = gesture.location(in: collectionView)
        
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gestureLocation) else {return}
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FlowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colors.remove(at: sourceIndexPath.row)
        colors.insert(item, at: destinationIndexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FlowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.2,
                      height: collectionView.frame.width / 3.2)
    }
}

// MARK: - SwiftUI
import SwiftUI
struct FlowProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let tabBar = MainTabBarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> MainTabBarController {
            return tabBar
        }
        
        func updateUIViewController(_ uiViewController:   FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
            
        }
    }
}
