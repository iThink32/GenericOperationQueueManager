//
//  GenericOperation.swift
//  TestOperationQueue
//
//  Created by N.A Shashank on 31/01/19.
//

import Foundation

class GenericOperation:Operation {
    
    typealias CompletionCallBack = () -> Void
    typealias TaskType = (@escaping CompletionCallBack) -> Void
//    let dataModel:T
    let closureTask:TaskType

    init(closureTask:@escaping TaskType) {
        self.closureTask = closureTask
//        self.dataModel = dataModel
        // a little concept here , here Operation does not override init() of NSObject neither does Generic Operation so first init(closure.... initializes the subclass and then calls its superclass init() which is ultimately NSOBject's init() ,that is why we first have to call super.init() before self.completionBlock=...
        //super.init()
        //self.completionBlock = completionBlock
    }
    
    var isCurrentlyExecuting = false
    
    override var isExecuting: Bool {
        set{
            willChangeValue(for: \GenericOperation.isExecuting)
            self.isCurrentlyExecuting = newValue
            didChangeValue(for: \GenericOperation.isExecuting)
        } get{
            return isCurrentlyExecuting
        }
    }
    
    var isCurrentlyFinished = false
    
    override var isFinished: Bool {
        set{
            willChangeValue(for: \GenericOperation.isFinished)
            self.isCurrentlyFinished = newValue
            didChangeValue(for: \GenericOperation.isFinished)
        } get{
            return self.isCurrentlyFinished
        }
    }
    
    
    override func main() {
        
        //check if cancelled
        guard isCancelled == false else{
            return
        }
        
        self.isExecuting = true
        //perform task
        self.closureTask(){[weak self] in
            self?.isExecuting = false
            self?.isFinished = true
        }
        
    }
    deinit {
        print("\(self) deallocated")
    }
    
    
}
