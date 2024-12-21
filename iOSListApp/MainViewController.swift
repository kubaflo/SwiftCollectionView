//
//  ViewController.swift
//  iOSListApp
//
//  Created by Jakub Florkowski on 21/12/2024.
//

import UIKit

class MainViewController: UIViewController {

    let systemImages = ["car", "car.2", "bolt.car",
                        "house.lodge", "house.and.flag", "music.note.house",
                        "air.purifier", "air.conditioner.horizontal.fill"]
    
    var previousSelection: DemoCollectionViewCell?
    
    private var containerView : UIView = {
        let container = UIView()
        container.backgroundColor = .red
        return container
    }()
    
    private lazy var mainCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: flowLayout)
        collectionView.register(DemoCollectionViewCell.self, forCellWithReuseIdentifier: DemoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func reloadCollectionView(){
        DispatchQueue.main.async{
            [weak self] in self?.mainCollectionView.reloadData()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer)
    {
        print("Hello World")
    }
    
    private func setupView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootView = windowScene.windows.first else {
            return
        }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        containerView.addGestureRecognizer(tap)
        
        // Set containerView frame based on safeAreaInsets
        containerView.frame = CGRect(
            x: 0,
            y: rootView.safeAreaInsets.top,
            width: rootView.frame.width,
            height: 500
        )
        
        // Add containerView to the view hierarchy
        view.addSubview(containerView)
        
        // Add mainCollectionView to containerView
        containerView.addSubview(mainCollectionView)
        
        // Use Auto Layout for mainCollectionView
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            mainCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return systemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCollectionViewCell.identifier, for: indexPath) as! DemoCollectionViewCell;
        cell.configure(with: systemImages[indexPath.row])
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = mainCollectionView.frame.width/3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the previously selected cell
           if let previousCell = previousSelection {
               previousCell.backgroundColor = .clear // Reset the previous cell's background color
           }
        
        // Get the currently selected cell
          if let selectedCell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell {
              selectedCell.backgroundColor = .green // Highlight the selected cell
              previousSelection = selectedCell // Update the previousSelection to the currently selected cell
          }
    }
    
}

