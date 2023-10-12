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

    private var spinningCirclesView = SpinningCirclesView()

    private var collectionView: UICollectionView!
    private let cellIdentifier = "MainViewCustomCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        addOnView()
        viewLayout()
    }

    private func setupCollectionView() {
        let layout = UPCarouselFlowLayout()
        
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainViewCustomCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func addOnView() {
        viewList = [spinningCirclesView, collectionView]

        for uiView in viewList {
            view.addSubview(uiView)
        }
    }

    private func viewLayout() {
        view.backgroundColor = .black
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 26, smallCircleSize: 6, radius: 20)
        
        spinningCirclesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(90)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(100)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MainViewCustomCollectionCell

        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
