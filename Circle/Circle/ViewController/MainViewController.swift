//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var separator: UIView = IntroView().separator()
    private var spinningCirclesView = SpinningCirclesView()
    private var followingPostsCollectionView: UICollectionView = UICollectionView()
    
    private let navigationTitleViewLabel: UILabel = IntroView().introMainTitleLabel()
    
    private var segmentedControl: UISegmentedControl = MainView().createSegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
        addOnContentView()
        contentViewLayout()
        navigationBarLayout()
        addTargets()
        setupSwipeGesture()

        followingPostsCollectionView.dataSource = self
        followingPostsCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinningCirclesView.startAnimation()
    }

    private func addOnView() {
        viewList = [scrollView, segmentedControl, separator]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        scrollView.addSubview(contentView)
    }

    private func viewLayout() {
        view.backgroundColor = UIColor.black
        scrollView.backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
            
        createBottomLine(for: segmentedControl)
        scrollView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func createBottomLine(for segmentedControl: UISegmentedControl) {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.red.cgColor // 원하는 색상으로 설정
        bottomLine.frame = CGRect(x: 0, y: segmentedControl.frame.height - 1, width: segmentedControl.frame.width, height: 1)
        segmentedControl.layer.addSublayer(bottomLine)
    }
    
    private func addOnContentView() {
        contentViewList = [followingPostsCollectionView]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
        
        followingPostsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func contentViewLayout() {
        followingPostsCollectionView.register(FollowingPostsCollectionViewCell.self, forCellWithReuseIdentifier: "FollowingPostsCollectionViewCell")

    }
    
    private func navigationBarLayout() {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "bell")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)), style: .done, target: self, action: nil)
        spinningCirclesView.setCircleSizes(bigCircleSize: 20, smallCircleSize: 5, radius: 17)

        rightButton.tintColor = UIColor.white

        navigationTitleViewLabel.text = "C"
        navigationTitleViewLabel.font = UIFont(name: "PetitFormalScript-Regular", size: 28)
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.titleView = spinningCirclesView
    }
    
    private func setupSwipeGesture() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRightGesture.direction = .left
        self.view.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeftGesture.direction = .right
        self.view.addGestureRecognizer(swipeLeftGesture)
    }

    private func addTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func swipeRight(_ gesture: UISwipeGestureRecognizer) {
        if segmentedControl.selectedSegmentIndex == 0 {
            segmentedControl.selectedSegmentIndex = 1
            segmentedControlValueChanged(segmentedControl)
        }
    }

    @objc private func swipeLeft(_ gesture: UISwipeGestureRecognizer) {
        if segmentedControl.selectedSegmentIndex == 1 {
            segmentedControl.selectedSegmentIndex = 0
            segmentedControlValueChanged(segmentedControl)
        }
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // "팔로우 중" 선택 시 처리
            break
        case 1:
            // "가입 서클" 선택 시 처리
            break
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingPostsCollectionViewCell", for: indexPath) as! FollowingPostsCollectionViewCell

        
        return cell
    }
}

