//
//  ThreadExtension.swift
//  PlanetsApp
//
//  Created by Gavin Ross on 19/05/2023.
//

import Foundation

public extension Thread {
    class func runOnMain(handler: () -> Void) {
        if Thread.isMainThread {
            handler()
            return
        }
        DispatchQueue.main.sync {
            handler()
        }
    }
}
