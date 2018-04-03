//
//  CustomLoadingView.swift
//  LoadingView
//
//  Created by chuangchuang wang on 2018/4/3.
//  Copyright © 2018年 chuangchuang wang. All rights reserved.
//

import UIKit

class CustomLoadingView: UIView {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var barStyle: UIStatusBarStyle = .lightContent
    
    // progress view's width and height must be equal to xib's circile view's constraint
    private lazy var progressView = LoadingView(frame: CGRect(x: 0, y: 0, width: 60.0, height: 60.0),
                                                lineWidth: 3.0,
                                                lineColors: [CycleColorRed])
    private let progressViewWidth: CGFloat = 200.0
    private let animationDuration: TimeInterval = 2.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.9)
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.textColor = CycleColorWhite
        self.circleView.addSubview(self.progressView)
        self.barStyle = UIApplication.shared.statusBarStyle
    }
    
    static func loading(title: String?) -> CustomLoadingView? {
        let loading = Bundle.main.loadNibNamed("CustomLoadingView", owner: self, options: nil)?.first as? CustomLoadingView
        loading?.titleLabel.text = title
        return loading
    }
    
    func show(on view: UIView) {
        view.addSubview(self)
        self.progressView.startAnimation()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func dismiss() {
        self.progressView.endAnimation()
        self.removeFromSuperview()
        UIApplication.shared.statusBarStyle = self.barStyle
    }
    
    deinit {
    }
}
