# AsyncDrawingLayer
Async Drawing Layer to handle complex view.

## 知识点概要整理

结构组成：
TextKit + WebKit = CoreText -> Core Graphics

CoreText 优势：
* 内存更少，渲染速度快
* 后台渲染 CFFrame
* 排版干预

调用顺序：
CoreText -> CoreFoundation -> C Api

C Api：
* __bridge：只做属性，不做处理
* __bridge_retained：OC->CF ARC->MRC
* __bridge_transfer：CF->OC MRC->ARC

create/copy => CFRelease

调用 CALayer -(void)drawRect: CGRect rect {} 方法：
* 1.调用父类方法
* 2.创建 context 上下文
* 3.坐标反转
* 4.绘制 path 路径
* 5.设置 NSAttributesString 富文本内容
* 6.Draw 方法绘制
* 7.CFRelease释放
