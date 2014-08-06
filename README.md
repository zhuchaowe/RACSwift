RACSwift
========

make easy use rac in swift

[EasyIOS](https://github.com/zhuchaowe/EasyIOS)

####补丁:解决Swift中取消OC的复杂弘定义导致的ReactiveCocoa无法在Swift中使用的问题

* 1.添加 `RACSwift.swift` 到`swift` 项目中
* 2.替换 `RACCommand.m`、`RACSignal+Operations.h`、`RACSignal+Operations.m` 三个文件
* 3.设置`Objective-C Bridging Header`为`${PODS_ROOT}/Headers/EasyIOS/swift-bridge.h`

___

###Usage

`RAC` In `Objective－C`:

	RAC(self.collectionView,page) = RACObserve(self.collectionView,page);

In `Swift`:

	RAC(self.collectionView,"page") <= RACObserve(self.collectionView,"page")
	
___
    
`RACObserve` In `Objective－C`:
	
	[RACObserve(self.demoSceneModel.goodsListRequest, state) //监控 网络请求的状态
     subscribeNext:^(NSString *text) {
     	NSLog(@"%@",text);
     }];

In `Swift`:

       RACObserve(self.collectionView,"page")
       .subscribeNextAs{
            (text:String) -> () in
            println(text)
        }