//
//  SqliteBufferController.swift
//
//  Created by Lawalong on 16/5/16.
//
//

/// Customise Log function
func Klog<T>(_ message: T, fileName: String = #file, methodName:
    String = #function, lineNumber: Int = #line){
    #if DEBUG
        print("\((fileName as NSString).pathComponents.last!).\(methodName)[\(lineNumber)]:\(message)")
    #endif
}
