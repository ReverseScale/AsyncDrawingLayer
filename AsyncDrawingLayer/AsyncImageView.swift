//
//  AsyncImageView.swift
//  AsyncDrawingLayer
//
//  Created by Steven Xie on 2019/2/13.
//  Copyright © 2019 Steven Xie. All rights reserved.
//

import UIKit

class AsyncImageView: UIView {
    
    var image: UIImage = UIImage() {
        didSet { contentNeedUpdate() }
    }
    
    override class var layerClass: AnyClass {
        return YYAsyncLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentNeedUpdate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentNeedUpdate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentNeedUpdate()
    }
    
    func contentNeedUpdate() {
        layer.setNeedsDisplay()
    }
}

extension AsyncImageView: YYAsyncLayerDelegate {
    var newAsyncDisplayTask: YYAsyncLayerDisplayTask {
        
        let task = YYAsyncLayerDisplayTask()
        
        task.willDisplay = {layer in
            
        }
        
        task.display = { context, size, isCancelled in
            
            guard let cgimage = self.image.cgImage else { return }
            context.draw(cgimage, in: CGRect(origin: .zero, size: size))
            
        }
        
        task.didDisplay = { layer, flag in
            
        }
        
        return task
    }
}
