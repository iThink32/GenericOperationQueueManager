//
//  OperationQueueManager.swift
//  TestOperationQueue
//
//  Created by N.A Shashank on 31/01/19.
//

import Foundation

class OperationQueueManager {
    
    private lazy var dictOperations:[AnyHashable:[Operation]] = [AnyHashable:[Operation]]()
    private lazy var operationQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Generic Operation Queue"
        return queue
    }()
    
    @discardableResult func cancelOperations(index:AnyHashable) -> Bool {
        guard let arrOperations = self.dictOperations[index] else{
            return false
        }
        arrOperations.forEach { (operation) in
            operation.cancel()
        }
        self.dictOperations[index] = nil
        return true
    }
    
    @discardableResult func addOperationToQueue(op:[Operation],index:AnyHashable) -> Bool {
        guard dictOperations[index] == nil else{
            return false
        }
        op.forEach {[weak self] (operation) in
            self?.operationQueue.addOperation(operation)
        }
        self.dictOperations[index] = op
        return true
    }

    /// This func is used to generate dependencies between operation based on a string.
    ///
    /// - Parameters:
    ///   - dependencyString:It has the format op1->op2->op3 where op1,op2 and op3 are the operations
    ///   and the arrows represent its dependency.Do not add spaces anywhere in the string
    ///   - dictValues: a dictionary specifying the operations corresponding to its keys for
    ///   eg: "op1":OperationInstance
    /// - Returns:True if it is successfully able to add dependencies false if not
    func addDependenenciesBasedOn(dependencyString:String,dictValues:[String:Operation]) -> Bool {
        // parse components
        let arrComponents = dependencyString.components(separatedBy: ",")
        for strComponent in arrComponents {
            let operationComponents = strComponent.components(separatedBy: "->")
            guard operationComponents.count == 2,let operationOne = dictValues[operationComponents[0]],let operationTwo = dictValues[operationComponents[1]] else{
                return false
            }
            operationOne.addDependency(operationTwo)
            self.operationQueue.addOperations([operationTwo,operationOne], waitUntilFinished: false)
        }
        return true
    }
    
    
}
