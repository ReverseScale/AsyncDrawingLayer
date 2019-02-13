//
//  ViewController.swift
//  AsyncDrawingLayer
//
//  Created by Steven Xie on 2019/2/13.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = AsyncLabel()
        textView.frame = CGRect(origin: CGPoint(x: 0, y: 90), size: view.bounds.size)
        textView.font = .systemFont(ofSize: 11)
        textView.isOpaque = false
        textView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textView.layer.shadowOffset = .zero
        textView.layer.shadowRadius = 1
        textView.layer.shadowOpacity = 0.1
        textView.isAsynchronously = true
        textView.text = "(˶‾᷄ ⁻̫ ‾᷅˵) emoji: 🇹🇱🇰🇵🇨🇬🇰🇵🇬🇱🇱🇮🇲🇶🇬🇷🇬🇷🇭🇺🎃😵😼🤧💀👋🙀🙀👍😼👄👅👥👨🏾‍⚕️👨🏿‍🍳👨🏾‍⚕️🧚🏾‍♂️🧞‍♀️🧞‍♀️🧤🎩🧢🎓🐭🧳👛👜🐼🐨🐻🦊🦅🐒🐤🐗🕸🕷🦑🐟🐬🐳🐅🦍🍖🍟⚽️🏓🥅🥋🔨🇭🇺🎃😵😼🤧💀👋🙀🙀👍😼👄👅👥👨🏾‍⚕️👨🏿‍🍳👨🏾‍⚕️🧚🏾‍♂️🧞‍♀️🧞‍♀️🧜‍♀️👨‍👩‍👦‍👦💑💏👫🙍🏻‍♀️👨‍👦‍👦🧵👗🧦🧢👢🧤🎩🧢🎓🐭🧳👛👜🐼🐨🐻🦊🦅🐒🐤🐗🕸🕷🦑🐟🐬🐳🐅🦍🍖🍟⚽️🏓🥅🥋🔨 (˶‾᷄ ⁻̫ ‾᷅˵) "
        view.addSubview(textView)
        
        let imageView = AsyncImageView()
        imageView.image = UIImage(named: "avatar")!
        imageView.frame = CGRect(x: 30, y: 90, width: 60, height: 60)
        view.addSubview(imageView)
    }
}


