//
//  ViewController.swift
//  AsyncDrawingLayer
//
//  Created by Steven Xie on 2019/2/13.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let textView = AsyncTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(AsyncImageView(frame: CGRect(x: 30, y: 90, width: 60, height: 60)))
        
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
    }
}

class AsyncImageView: UIView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.lightGray
        
        contentNeedUpdate()
    }
    
    override class var layerClass: AnyClass {
        return YYAsyncLayer.self
    }
    
    func contentNeedUpdate() {
        layer.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AsyncImageView: YYAsyncLayerDelegate {
    var newAsyncDisplayTask: YYAsyncLayerDisplayTask {
        
        let task = YYAsyncLayerDisplayTask()
        
        task.willDisplay = {layer in
            
        }
        
        task.display = { context, size, isCancelled in
            
            guard let cgimage = UIImage(named: "avatar")?.cgImage else { return }
            context.draw(cgimage, in: CGRect(origin: .zero, size: size))
        }
        
        task.didDisplay = { layer, flag in
            
        }
        
        return task
    }
}

class AsyncTextView: UIView {
    
    var font: UIFont = .systemFont(ofSize: 16) {
        didSet { updatedTransaction() }
    }
    
    var text: String = "" {
        didSet { updatedTransaction() }
    }
    
    /// 是否异步处理
    var isAsynchronously: Bool {
        set { (layer as? AsyncLayer)?.isAsynchronously = newValue }
        get { return (layer as? AsyncLayer)?.isAsynchronously ?? false }
    }
    
    override class var layerClass: AnyClass {
        return AsyncLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updatedTransaction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updatedTransaction()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatedTransaction()
    }
    
    private func updatedTransaction() {
        Transaction.commit(self, with: #selector(contentsNeedUpdated))
    }
    
    @objc private func contentsNeedUpdated() {
        layer.setNeedsDisplay()
    }
}

extension AsyncTextView: AsyncLayerDelegate {
    
    func display(draw layer: AsyncLayer, at context: CGContext, with size: CGSize, isCancelled: (() -> Bool)) {
        
        // 将坐标系上下翻转
        context.textMatrix = .identity
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        
        let textPath = CGMutablePath()
        textPath.addRect(CGRect(origin: .zero, size: size))
        context.addPath(textPath)
        
        // 根据framesetter和绘图区域创建CTFrame
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        
        let attrString = NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .kern: -0.5,
                .foregroundColor: UIColor.brown,
                .paragraphStyle: style
            ]
        )
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        let frame = CTFramesetterCreateFrame(
            framesetter, CFRangeMake(0, attrString.length),
            textPath,
            nil
        )
        // 使用CTFrameDraw进行绘制
        CTFrameDraw(frame, context)
    }
}
