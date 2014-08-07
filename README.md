RACSwift
========

make easy use rac in swift

* [EasyIOS](https://github.com/zhuchaowe/EasyIOS)
* [ReactiveCocoa](https://github.com/zhuchaowe/ReactiveCocoa)

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
	RACObserve(self.collectionView,"page") => RAC(self.collectionView,"page")
	
___
    
`RACObserve` In `Objective－C`:
	
        [[[RACObserve(self.collectionView, page)
         map:^NSString*(NSNumber* newPage) {
             return @"123";
         }]
         filter:^BOOL(NSString* newPage) {
             return false;
         }]
         subscribeNext:^(NSString* text) {
             NSLog(@"%@",text);
         }];

In `Swift`:

        RACObserve(self.collectionView,"page")
        .mapAs{
            (newpage:NSNumber) -> NSString in
            return "123"
        }
        .filterAs{
            (newpage:NSString) -> Bool in
            return false
        }
        .subscribeNextAs{
            (text:String) -> () in
            println(text)
        }        