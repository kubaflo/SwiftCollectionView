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
    
    var tap: UIGestureRecognizer?
    
    private var containerView : UIView = {
        let container = UIView()
        container.backgroundColor = .gray
        return container
    }()
    
    private var button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.translatesAutoresizingMaskIntoConstraints = false;
        return button
    }()
    
    private var switcher : UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    private lazy var mainCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
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
        view.backgroundColor = .white
        setupView()
    }
    
    func reloadCollectionView(){
        DispatchQueue.main.async{
            [weak self] in self?.mainCollectionView.reloadData()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: "Hello!", message: "Gesture recognizer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch)
    {
        if(sender.isOn)
        {
            containerView.addGestureRecognizer(tap!)
        }
        else
        {
            containerView.removeGestureRecognizer(tap!)
        }
    }
    
    @objc func buttonClicked()
    {
        let alert = UIAlertController(title: "Hello!", message: "Button was clicked", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootView = windowScene.windows.first else {
            return
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        containerView.frame = CGRect(
            x: 0,
            y: rootView.safeAreaInsets.top,
            width: rootView.frame.width,
            height: 400
        )
        
        button.setTitle("Hello World!", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        switcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
        containerView.addSubview(mainCollectionView)
        containerView.addSubview(button)
        view.addSubview(containerView)
        view.addSubview(switcher)
    
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: 300),
            mainCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.topAnchor.constraint(equalTo: mainCollectionView.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            switcher.topAnchor.constraint(equalTo: containerView.bottomAnchor)
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
        let size = mainCollectionView.frame.width
        return CGSize(width: size - 40, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = mainCollectionView.frame.width - 40
        let x = (mainCollectionView.frame.width - width)
        return UIEdgeInsets(top: 0, left: x/2, bottom: 0, right: x/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           if let previousCell = previousSelection {
               previousCell.backgroundColor = .clear
           }
        
          if let selectedCell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell {
              selectedCell.backgroundColor = .green
              previousSelection = selectedCell
          }
    }
    
}

