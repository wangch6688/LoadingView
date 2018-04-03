//
//  ViewController.swift
//  LoadingView
//
//  Created by chuangchuang wang on 2018/4/3.
//  Copyright © 2018年 chuangchuang wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
    let loadingView = CustomLoadingView.loading(title: "Loading")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultSetting()
    }
    
    func defaultSetting() {
        button.setTitle("show loading", for: .normal)
        button.backgroundColor = CycleColorRed
        button.addTarget(self, action: #selector(showLoadingView), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    func showLoadingView() {
        loadingView?.show(on: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

