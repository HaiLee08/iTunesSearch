//
//  FilterView.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/17/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class FilterView: UIView, UIGestureRecognizerDelegate, NibLoadable {
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    private enum Const {
        static let height: CGFloat = 200
    }
    
    var didTapOk: ((_ mediaType: MediaType) -> Void)? = nil
    var isAnimating = false
    var isOpen = false
    private var mediaType: MediaType = .all
    
    private var backgroundView: UIView = {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return backgroundView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: Const.height)
        addBackgroundGesture()
    }
    
    func addBackgroundGesture() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        tabGesture.delegate = self
        backgroundView.addGestureRecognizer(tabGesture)
    }
    
    // MARK: Actions
    @IBAction func buttonOKTapped(_ sender: Any) {
        hideView {
            self.didTapOk?(self.mediaType)
        }
    }
    
    @IBAction func buttonsFilterTapped(_ button: UIButton) {
        updateButtonsColor(selectedButton: button)
        if let index = buttonCollection.index(where: { $0 === button }) {
            if index == 0 { mediaType = .movie }
            else if index == 1 { mediaType = .podcast }
            else if index == 2 { mediaType = .music }
            else { mediaType = .all }
        }
    }
    
    func updateButtonsColor(selectedButton: UIButton) {
        buttonCollection.forEach { (button) in
            button.borderColor = UIColor(white: 0.4, alpha: 1)
            button.setTitleColor(UIColor(white: 0.4, alpha: 1), for: .normal)
        }
        selectedButton.borderColor = UIColor(white: 0.9, alpha: 1)
        selectedButton.setTitleColor(UIColor(white: 0.9, alpha: 1), for: .normal)
    }
}

extension FilterView {

    func show(completion: (() -> Void)? = nil) {
        if isAnimating { return }
        addSubviewSelf()
        
        var finalFrame = frame
        finalFrame.size.height = Const.height
        frame = finalFrame
        
        isAnimating = true
        layoutIfNeeded()
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1.0,
                       options: .curveLinear,
                       animations: {
                        
                        self.frame = CGRect(x: 0, y: SCREEN_HEIGHT - Const.height, width: SCREEN_WIDTH, height: Const.height)
                        self.layoutIfNeeded()
                        
        }) { (finished) in
            self.isAnimating = !finished
            self.isOpen = finished
            completion?()
        }
    }
    
    private func hideView(completion: (() -> Void)? = nil) {
        if isAnimating { return }
        
        if isOpen {
            isAnimating = true
            var finalFrame = frame
            finalFrame.origin.y = SCREEN_HEIGHT
            
            UIView.animate(withDuration: 0.2,
                           animations: {
                            self.frame = finalFrame
            }) { (finished) in
                self.isAnimating = !finished
                completion?()
                self.isOpen = finished
                self.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
            }
        } else {
            completion?()
        }
    }
    
    @objc func hide()  {
        hideView()
    }
    
    func addSubviewSelf()  {
        backgroundView.addSubview(self)
        UIApplication.shared.keyWindow?.addSubview(backgroundView)
    }
}
