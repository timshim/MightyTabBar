//
//  MightyTabBar.swift
//  MightyTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

protocol MightyTabBarDelegate: class {
    func didSelectTab(index: Int)
}

class MightyTabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private enum TabBarState {
        case expanded, collapsed
    }

    private let handleView = UIView()

    weak var delegate: MightyTabBarDelegate?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.dataSource = self
        cv.delegate = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleReorder(_:)))
        cv.addGestureRecognizer(longPress)
        return cv
    }()

    private lazy var draggableView: UIView = {
        let dv = UIView()
        dv.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragView(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dv.addGestureRecognizer(panGesture)
        dv.addGestureRecognizer(tapGesture)

        handleView.backgroundColor = handleColor

        dv.addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.widthAnchor.constraint(equalTo: dv.widthAnchor, multiplier: 0.2).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        handleView.centerXAnchor.constraint(equalTo: dv.centerXAnchor).isActive = true
        handleView.centerYAnchor.constraint(equalTo: dv.centerYAnchor).isActive = true
        handleView.layer.cornerRadius = 3

        return dv
    }()

    private let cellId = "cellId"
    private let screenHeight = UIScreen.main.bounds.size.height
    private var maxHeight: CGFloat = 220
    private let minHeight: CGFloat = 120
    private let dragAreaHeight: CGFloat = 20
    private let animDuration: TimeInterval = 0.2
    let tabItemHeight: CGFloat = 80

    private var isOpen = false
    private var tabState: TabBarState {
        return isOpen ? .collapsed : .expanded
    }
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgress: CGFloat = 0

    var tabBarItems: [[String: String]] = [] {
        didSet {
            let rowCount = ceil(Double(tabBarItems.count) / Double(itemCountInRow))
            maxHeight = (CGFloat(rowCount) * tabItemHeight) + 40
            cvHeightConstraint.constant = CGFloat(rowCount) * tabItemHeight
        }
    }
    var bgColor: UIColor = .white {
        didSet {
            backgroundColor = bgColor
            collectionView.backgroundColor = bgColor
            draggableView.backgroundColor = bgColor
        }
    }
    var handleColor: UIColor = UIColor(displayP3Red: 149/255, green: 165/255, blue: 166/255, alpha: 1) {
        didSet {
            handleView.backgroundColor = handleColor
        }
    }
    var itemCountInRow: Int = 5 {
        didSet {
            if itemCountInRow > 5 {
                itemCountInRow = 5
            } else if itemCountInRow < 2 {
                itemCountInRow = 2
            }
        }
    }
    var selectedColor: UIColor = .red
    var deselectedColor: UIColor = .black

    private var cvHeightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
        backgroundColor = bgColor
        collectionView.backgroundColor = bgColor
        draggableView.backgroundColor = bgColor

        collectionView.register(TabBarItem.self, forCellWithReuseIdentifier: cellId)

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: dragAreaHeight).isActive = true
        cvHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: tabItemHeight)
        cvHeightConstraint.isActive = true

        addSubview(draggableView)
        draggableView.translatesAutoresizingMaskIntoConstraints = false
        draggableView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        draggableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        draggableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        draggableView.heightAnchor.constraint(equalToConstant: dragAreaHeight).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabBarItem = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabBarItem
        let item = tabBarItems[indexPath.item]
        if let name = item["name"], let image = item["image"] {
            tabBarItem.title.text = name
            tabBarItem.title.textColor = deselectedColor
            tabBarItem.icon.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            tabBarItem.tintColor = deselectedColor
            tabBarItem.selectedColor = selectedColor
            tabBarItem.deselectedColor = deselectedColor
        }
        return tabBarItem
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(itemCountInRow), height: tabItemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTab(index: indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let initialIndex = sourceIndexPath.item
        let finalIndex = destinationIndexPath.item

        let initialItem = tabBarItems[initialIndex]
        tabBarItems.remove(at: initialIndex)
        tabBarItems.insert(initialItem, at: finalIndex)

        let firstIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndex, animated: false, scrollPosition: [])
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            animateTransition(state: tabState)
        }
    }

    @objc private func handleDragView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            startInteractiveTransition(state: tabState)
        case .changed:
            let translation = sender.translation(in: draggableView)
            var fractionComplete = translation.y / maxHeight
            fractionComplete = isOpen ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default: break
        }
    }

    private func startInteractiveTransition(state: TabBarState) {
        if runningAnimations.isEmpty {
            animateTransition(state: state)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgress
        }
    }

    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    private func animateTransition(state: TabBarState) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: animDuration, curve: .easeInOut) {
                switch state {
                case .expanded:
                    self.frame.origin.y = self.screenHeight - self.maxHeight
                    self.frame.size.height = self.maxHeight
                case .collapsed:
                    self.frame.origin.y = self.screenHeight - self.minHeight
                    self.frame.size.height = self.minHeight
                }
            }

            frameAnimator.addCompletion { _ in
                self.isOpen = !self.isOpen
                self.runningAnimations.removeAll()
            }

            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }

    @objc private func handleReorder(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

}

class TabBarItem: UICollectionViewCell {

    fileprivate let icon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        return iv
    }()
    fileprivate let title: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 1
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.textColor = .black
        return label
    }()
    private let badgeView: BadgeView = {
        let bv = BadgeView()
        return bv
    }()
    var badgeCount: Int {
        didSet {
            badgeView.title.text = "\(badgeCount)"
            setupCell()
        }
    }
    var selectedColor: UIColor = .red
    var deselectedColor: UIColor = .black {
        didSet {
            icon.tintColor = deselectedColor
        }
    }
    override var isSelected: Bool {
        didSet {
            icon.tintColor = isSelected ? selectedColor : deselectedColor
            title.textColor = isSelected ? selectedColor : deselectedColor
        }
    }
    override var isHighlighted: Bool {
        didSet {
            icon.tintColor = isHighlighted ? selectedColor : deselectedColor
            title.textColor = isHighlighted ? selectedColor : deselectedColor
        }
    }

    override init(frame: CGRect) {
        self.badgeCount = 0
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true

        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 0).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        title.heightAnchor.constraint(equalToConstant: 15).isActive = true

        if badgeCount > 0 {
            badgeView.title.text = "\(badgeCount)"
            addSubview(badgeView)
            badgeView.translatesAutoresizingMaskIntoConstraints = false
            badgeView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 15).isActive = true
            badgeView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
            badgeView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            badgeView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            badgeView.layer.cornerRadius = 10
        } else {
            badgeView.removeFromSuperview()
        }
    }

}

private class BadgeView: UIView {

    fileprivate let title: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .red

        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
