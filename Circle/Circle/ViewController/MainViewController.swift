//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var separator: UIView = IntroView().separator()
    private var spinningCirclesView = SpinningCirclesView()
    //    private var followingPostsCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let navigationTitleViewLabel: UILabel = IntroView().introMainTitleLabel()
    
    private var segmentedControl: UISegmentedControl = MainView().createSegmentedControl()
    
    let followingPostsTableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
        addOnContentView()
        contentViewLayout()
        navigationBarLayout()
        addTargets()
        setupSwipeGesture()
        
        followingPostsTableView.dataSource = self
        followingPostsTableView.delegate = self
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinningCirclesView.startAnimation()
    }
    
    private func addOnView() {
        viewList = [segmentedControl, separator, followingPostsTableView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = UIColor.black
        followingPostsTableView.backgroundColor = UIColor.black
//        scrollView.backgroundColor = UIColor.black
//        contentView.backgroundColor = UIColor.black
        
//        scrollView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.trailing.bottom.equalToSuperview()
//        }
        
//        segmentedControl.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.centerX.equalToSuperview()
//            make.width.equalToSuperview()
//            make.height.equalTo(30)
//        }
        
//        separator.snp.makeConstraints { make in
//            make.top.equalTo(segmentedControl.snp.bottom).offset(15)
//            make.width.equalToSuperview()
//            make.height.equalTo(1)
//        }
        
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalToSuperview()
//            make.height.equalTo(1000)
//        }
        
        scrollView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func addOnContentView() {
//        contentViewList = [followingPostsCollectionView]
//        
//        for uiView in contentViewList {
//            contentView.addSubview(uiView)
//        }
        
        followingPostsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func contentViewLayout() {
        followingPostsTableView.register(FollowingPostsCollectionViewCell.self, forCellReuseIdentifier: "FollowingPostsCollectionViewCell")
    }
    
    private func navigationBarLayout() {
        let alarmBarButton = UIButton()
        let boltBarButton = UIButton()
        
        if let image = UIImage(systemName: "bell") {
            alarmBarButton.setImage(image, for: .normal)
        }
        
        if let image = UIImage(systemName: "bolt") {
            boltBarButton.setImage(image, for: .normal)
        }
        
        alarmBarButton.tintColor = UIColor.white
        boltBarButton.tintColor = UIColor.white
        alarmBarButton.contentHorizontalAlignment = .fill
        alarmBarButton.contentVerticalAlignment = .fill
        boltBarButton.contentHorizontalAlignment = .fill
        boltBarButton.contentVerticalAlignment = .fill
                
        alarmBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 27, height: 27))
        }
        
        boltBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 27, height: 27))
        }
        
        let righthStackview = UIStackView.init(arrangedSubviews: [boltBarButton, alarmBarButton])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15

        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
        
//        navigationController?.navigationBar.backgroundColor = UIColor.black
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 18.5, smallCircleSize: 4.5, radius: 15.5)
        navigationTitleViewLabel.text = "C"
        navigationTitleViewLabel.font = UIFont(name: "PetitFormalScript-Regular", size: 28)
        
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsCollectionViewCell", for: indexPath) as!
        FollowingPostsCollectionViewCell
        
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

