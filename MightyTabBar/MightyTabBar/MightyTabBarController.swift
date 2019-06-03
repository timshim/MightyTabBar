//
//  MightyTabBarController.swift
//  MightyTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class MightyTabBarController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MightyTabBarDelegate {

    private lazy var mightyTabBar: MightyTabBar = {
        let mtb = MightyTabBar()
        mtb.delegate = self
        mtb.bgColor = bgColor
        return mtb
    }()

    private lazy var bottomView: UIView = {
        let bv = UIView()
        bv.backgroundColor = bgColor
        return bv
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    private let cellId = "cellId"
    private var currentIndex = 0

    var viewControllers = [UIViewController]()
    var tabBarItems: [[String: String]] = [] {
        didSet {
            mightyTabBar.tabBarItems = tabBarItems
        }
    }

    var bgColor: UIColor = .white {
        didSet {
            mightyTabBar.bgColor = bgColor
        }
    }
    var handleColor: UIColor = UIColor(displayP3Red: 149/255, green: 165/255, blue: 166/255, alpha: 0.5)
    var itemCountInRow: Int = 5 {
        didSet {
            mightyTabBar.itemCountInRow = itemCountInRow
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ViewControllerCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let initialTabIndex = IndexPath(item: 0, section: 0)
        mightyTabBar.collectionView.selectItem(at: initialTabIndex, animated: false, scrollPosition: [])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMightyTabBar()
    }

    private func setupMightyTabBar() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(mightyTabBar)
        mightyTabBar.translatesAutoresizingMaskIntoConstraints = false
        mightyTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mightyTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mightyTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mightyTabBar.heightAnchor.constraint(equalToConstant: mightyTabBar.tabItemHeight + 5).isActive = true

        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.bottom).isActive = true

        mightyTabBar.handleColor = handleColor
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ViewControllerCell

        let vc = viewControllers[indexPath.item]
        addChild(vc)
        cell.hostedView = vc.view
        vc.didMove(toParent: self)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func didSelectTab(index: Int) {
        if currentIndex == index {
            return
        }
        currentIndex = index
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        let vc = viewControllers[index]
        if vc.isViewLoaded {
            vc.viewDidAppear(false)
        }
    }

    func setBadge(count: Int, index: Int) {
        let index = IndexPath(item: index, section: 0)
        if let tabBarItem = mightyTabBar.collectionView.cellForItem(at: index) as? TabBarItem {
            tabBarItem.badgeCount = count
        }
    }

}

private class ViewControllerCell: UICollectionViewCell {

    fileprivate var hostedView: UIView? {
        didSet {
            guard let hostedView = hostedView else { return }

            hostedView.frame = contentView.bounds
            contentView.addSubview(hostedView)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        if hostedView?.superview == contentView {
            hostedView?.removeFromSuperview()
        }
        hostedView = nil
    }

}
