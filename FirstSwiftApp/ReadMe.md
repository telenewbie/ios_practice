
# 简介
 这是按照 appcoda 进行的测试 代码

1. 只是简单 的弹了 一个框
```Swift
let alertController = UIAlertController(title: "ok", message: wordToLookup, preferredStyle: UIAlertController.Style.alert);
           
alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
           
present(alertController, animated: true, completion: nil)
```
2.  入口函数为 `main.swift`  默认是用 `AppDelegate.swift` 采用注解的方式
3. 采用拖控件的方式进行 控件的布局，包括使用 `cmd + option + enter ` 进行 在线查看不同设备的布局效果，以及针对不同的设备 达到不同的 属性效果
4. Embed in view  StackView 还是挺好用的。
