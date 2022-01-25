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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .lightGray
        view.addSubview(collectionView)
  
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FlowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FlowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
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
        
        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
            
        }
    }
}
