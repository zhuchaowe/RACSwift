RACSwift
========

make easy use rac in swift

* 1.添加 RACSwift.swift 到swift 项目
* 2.替换 RACCommand.m、RACSignal+Operations.h、RACSignal+Operations.m 三个文件
* 3.设置`Objective-C Bridging Header`为`${PODS_ROOT}/Headers/EasyIOS/swift-bridge.h`


###Usage
`RAC` In `Objective－C`:

	RAC(self.collectionView,page) = RACObserve(self.collectionView,page);

In `Swift`:

	RAC(self.collectionView,"page") <= RACObserve(self.collectionView,"page");
	
___
    
`RACObserve` In `Objective－C`:
	
	[RACObserve(self.demoSceneModel.goodsListRequest, state) //监控 网络请求的状态
     subscribeNext:^(NSString *text) {
     	NSLog(@"%@",text);
     }

In `Swift`:

       RACObserve(self.collectionView,"page")
       .subscribeNextAs{
            (text:String) -> () in
            println(text)
        }