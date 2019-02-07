# GenericOperationQueueManager
A collection of classes that help you use operation queues without any effort

## Usage:-


### Creation of Operation with dependency :-

Drag and drop the files in this repo into your project then create an instance of OperatioQueueManager and add operations like so:

```
let operationQueueManager = OperationQueueManager()

let op1 = GenericOperation { [weak self] (completionClosure) in.  // weak is very important
            // make an asynchronous call
            // call completion handler back to let the operation queue know that you have finished your operation
              completionClosure()
            })
        }
        let op2 = GenericOperation {[weak self] (completionClosure) in // weak is very important
            // make an asynchronous call
            // call completion handler back to let the operation queue know that you have finished your operation
                completionClosure()
            })
        }
        operationQueue.addDependenenciesBasedOn(dependencyString: "op1->op2", dictValues: ["op1":op1,"op2":op2],index:IndexPath)
```

here the method addDependencies takes a string of the form op1->op2 , op2->op3 which internally adds op1 as a dependent of 
op2 and op2 as a dependent of op3.Read the function documentation for more details

Generic Operation is a class which you have to use to create an operation , do what you want but make sure that you call 
completionHandler() at the end.

Im using indexPath as an index to cancel operations later , you can use any object that conforms to AnyHashable.

### Cancel an Operation:-

```
operationQueue.cancelOperation(index:IndexPath)
```
where operationQueue is an instance of OperationQueue Manager


## Note:-

You can also use BlockOperations to achieve dependancy , ive purposely avoided it as it can be only used for synchronous operations which can easily achieved by using a custom synchronous queue.


