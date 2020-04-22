//
//  ViewController.swift
//  ProcessIOS
//
//  Created by newbie on 2020/4/9.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    //测试高阶函数
    @IBAction func testSwiftHighFun(_ sender: Any) {
        let value :[String?] = ["one","two","",nil]
        // 遍历数组
        value.forEach{val in print(val as Any)}
        // 两个集合进行合并，输出为一个集合
        // map：对每个元素进行处理
        
        value.compactMap{
            $0
        }.forEach{
            val in  print(val)
        }
        // 添加 1，one，2，two 类型
    }
    @IBAction func onTestSwiftClosure(_ sender: Any) {
        testSwiftClosure {
            print("closure")
        }
    }
    
    @IBAction func onTestRxSwift(_ sender: Any) {
        //        _ = Observable.just("1").subscribe(onNext: {
        //            print($0)
        //        }, onError: {
        //            print("error:\($0)")
        //        }, onCompleted: {
        //            print("complet")
        //        }, onDisposed: {
        //            print("dispose")
        //        })
        //        print("\(String(describing: Thread.current.name))")
        //线程切换操作
        //
        Completable.create{
            completable in
            completable(.completed)
            return Disposables.create()
        }
        Observable<Int>.create{observable in
            print("?😀 create: \(self.currentQueueName() ?? "queue")")
            observable.onNext(1);
            sleep(1)
            observable.onNext(2);
            return Disposables.create()
        }
        .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
        .map{value ->Int in
            print("\n\n 😀 Queue: \(self.currentQueueName() ?? "queue")")
            return value*2
        }.observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).map{value ->Int in
            print(" 😀 Queue: \(self.currentQueueName() ?? "queue")")
            return value*3
        }.observeOn(MainScheduler.instance)
            
            .subscribe(onNext: {
                element in
                print(" 😀 Queue: \(element) \(self.currentQueueName() ?? "queue")")
            }, onError: {error in print("error")}, onCompleted: {print("complete")}, onDisposed: {print("disposed")})
        
    }
    // 测试block
    @IBAction func testBlock(_ sender: Any) {
        helloOCBlock()
        print("调用完毕 hello Block");
        useBlock{
            a,b in
            return a + b
        }
    }
    
    
    
    @IBAction func showNotification(_ sender: Any) {
        // 发送通知
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        content.badge = 1
        content.subtitle = "what?subtitile"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "MEETING_INVITATION"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "hello world", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print("what")
        }
    }
    @IBAction func createProcess(_ sender: Any) {
        // 在协程上面触发
        DispatchQueue.global().async {
            // 创建进程
            createProcess_c()
            
        }
    }
    @IBOutlet weak var tv_first_name: UITextField!
    @IBOutlet weak var tv_last_name: UITextField!
    @IBOutlet weak var tv_login_result: UILabel!
    @IBAction func rxlogin(_ sender: Any) {
        Observable.combineLatest(tv_first_name.rx.text, tv_last_name.rx.text){
            "\($0 ?? ""):\($1 ?? "")"
        }.bind(to: tv_login_result.rx.text)
            .disposed(by: disposeBag)
    }
    //rx 定时器
    let disposeBag = DisposeBag()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let center = UNUserNotificationCenter.current()
        
        
        let center = UNUserNotificationCenter.current()
        // 申请权限 , 有回调哦
        center.requestAuthorization(options: [.alert,.badge,.sound,.carPlay,.provisional]) { (grant, error) in
            if grant {
                print("hello notification")
            }else{
                
            }
        }
        
        
        // 异常捕获
        signal(SIGABRT) { (code) in
            print("hello a crash")
            // 获取堆栈信息
          //	  NSUncaughtExceptionHandler(Uncaught)
        }
        
        //
        
        
    }
    func testSwiftClosure(closure:()->Void) {
        closure()
    }
    func currentQueueName() -> String? {
        let name = __dispatch_queue_get_label(nil)
        return String(cString: name, encoding: .utf8)
    }
    
}

