//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit
import UPCarouselFlowLayout

class MainViewController: UIViewController {
    
    private var viewList: [UIView] = []
    private let titleLabelList: [String] = ["Vitality", "Radiance", "Clarity", "Balance", "Calm", "Harmony", "Serenity", "Purity"]
    var colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.black, UIColor.white]

    private var spinningCirclesView = SpinningCirclesView()

    private var collectionView: UICollectionView!
    private let cellIdentifier = "MainViewCustomCollectionCell"
    
    private var MainViewTitleLabel: UILabel = MainView().MainViewTitleLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        addOnView()
        viewLayout()
        spinningCirclesView.startAnimation()
 
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        backButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    private func setupCollectionView() {
        let layout = UPCarouselFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainViewCustomCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        collectionView.isScrollEnabled = false
    }

    private func addOnView() {
        viewList = [spinningCirclesView, collectionView, MainViewTitleLabel]

        for uiView in viewList {
            view.addSubview(uiView)
        }
    }

    private func viewLayout() {
        view.backgroundColor = .black
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 26, smallCircleSize: 6, radius: 20)
        
        spinningCirclesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(85)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(100)
        }
        
        MainViewTitleLabel.text = titleLabelList[0]
        
        MainViewTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinningCirclesView.snp.bottom).offset(35)
        }
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MainViewCustomCollectionCell
        
        if indexPath.row == 6 {
            cell.imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.75).cgColor
            cell.imageView.layer.borderWidth = 1.5
        }
        
        cell.imageView.backgroundColor = colors[indexPath.row].withAlphaComponent(0.75)
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.transition(with: MainViewTitleLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.MainViewTitleLabel.text = self.titleLabelList[indexPath.row]
        }, completion: nil)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
