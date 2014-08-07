//
//  RACSwift.swift
//  easySwift
//
//  Created by 朱潮 on 14-8-6.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

import Foundation

struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

infix operator  <= {}
 func <= (rac: RAC, signal: RACSignal) {
    rac.assignSignal(signal)
}

infix operator  => {}
 func => (signal: RACSignal,rac: RAC) {
    rac.assignSignal(signal)
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}

extension RACSignal {
    func subscribeNextAs<T>(nextClosure:(T) -> ()) -> (RACDisposable) {
       return self.subscribeNext {
            (next: AnyObject!) -> () in
            let nextAsT = next as T
            nextClosure(nextAsT)
        }
    }
    
    func filterAs<T>(nextClosure:(T) -> Bool) -> (RACSignal) {
        return self.filter {
            (next: AnyObject!) -> Bool in
            let nextAsT = next as T
            return nextClosure(nextAsT)
        }
    }
    
    func mapAs<T>(nextClosure:(T) -> AnyObject!) -> (RACSignal) {
        return self.map {
            (next: AnyObject!) -> AnyObject! in
            let nextAsT = next as T
            return nextClosure(nextAsT)
        }
    }
}