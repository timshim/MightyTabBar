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

    enum TabBarState {
        case expanded, collapsed
    }

    let bgColor = UIColor(displayP3Red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
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

    lazy var draggableView: UIView = {
        let dv = UIView()
        dv.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragView(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dv.addGestureRecognizer(panGesture)
        dv.addGestureRecognizer(tapGesture)

        let handleView = UIView()
        handleView.backgroundColor = UIColor(displayP3Red: 149/255, green: 165/255, blue: 166/255, alpha: 1)

        dv.addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.widthAnchor.constraint(equalTo: dv.widthAnchor, multiplier: 0.2).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        handleView.centerXAnchor.constraint(equalTo: dv.centerXAnchor).isActive = true
        handleView.centerYAnchor.constraint(equalTo: dv.centerYAnchor).isActive = true
        handleView.layer.cornerRadius = 3

        return dv
    }()

    let cellId = "cellId"
    let screenHeight = UIScreen.main.bounds.size.height
    let maxHeight: CGFloat = 220
    let minHeight: CGFloat = 120
    let tabItemHeight: CGFloat = 80
    let dragAreaHeight: CGFloat = 20
    let animDuration: TimeInterval = 0.2

    var isOpen = false
    var tabState: TabBarState {
        return isOpen ? .collapsed : .expanded
    }
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgress: CGFloat = 0
    var tabItems: [[String: Any]] = [
        ["name": "Home", "image": "home"],
        ["name": "Explore", "image": "rocket"],
        ["name": "Camera", "image": "camera"],
        ["name": "Gift", "image": "gift"],
        ["name": "Settings", "image": "gear"],
        ["name": "Award", "image": "gift"],
        ["name": "Profile", "image": "home"],
        ["name": "Gear", "image": "gear"],
        ["name": "Discover", "image": "rocket"],
        ["name": "Photos", "image": "camera"]
    ]

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
        collectionView.heightAnchor.constraint(equalToConstant: tabItemHeight * 2).isActive = true

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
        return tabItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabBarItem
        let tabItem = tabItems[indexPath.item]
        if let name = tabItem["name"] as? String, let image = tabItem["image"] as? String {
            cell.title.text = name
            cell.title.textColor = .black
            cell.icon.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            cell.tintColor = .black
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: 80)
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

        let initialItem = tabItems[initialIndex]
        tabItems.remove(at: initialIndex)
        tabItems.insert(initialItem, at: finalIndex)

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

    func startInteractiveTransition(state: TabBarState) {
        if runningAnimations.isEmpty {
            animateTransition(state: state)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
        }
    }

    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgress
        }
    }

    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    func animateTransition(state: TabBarState) {
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

    let icon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        return iv
    }()
    let title: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 1
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.textColor = .black
        return label
    }()

    override var isSelected: Bool {
        didSet {
            icon.tintColor = isSelected ? .red : .black
            title.textColor = isSelected ? .red : .black
        }
    }
    override var isHighlighted: Bool {
        didSet {
            icon.tintColor = isHighlighted ? .red : .black
            title.textColor = isHighlighted ? .red : .black
        }
    }

    override init(frame: CGRect) {
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
    }

}
