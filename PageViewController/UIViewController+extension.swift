//
//  UIViewController+extension.swift
//  LFProgressView
//
//  Created by XieLibin on 16/7/4.
//  Copyright © 2016年 Menglingfeng. All rights reserved.
//

import UIKit


extension UIViewController{

    public override class func initialize() {
        super.initialize()
        
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        //make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        dispatch_once(&Static.token) { () -> Void in

            swizzleShouldAutorotate()
        }
    }

    //交换supportedInterfaceOrientations
    class func swizzleShouldAutorotate(){
        let originalSelector = #selector(UIViewController.supportedInterfaceOrientations)
        let swizzleSelector = #selector(UIViewController.custom_supportedInterfaceOrientations)
        swizzle(swizzleSelector, withOriginalSelector: originalSelector)
    }
    
    
    class func swizzle(method : Selector,withOriginalSelector original : Selector){
        
        let originalMethod = class_getInstanceMethod(self, original)
        let swizzleMethod = class_getInstanceMethod(self, method)
        
        let didAddMethod = class_addMethod(self, original, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        
        if didAddMethod {
            class_replaceMethod(self, method, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
    }
    
    
    
    func custom_supportedInterfaceOrientations() ->UIInterfaceOrientationMask {
        self.custom_supportedInterfaceOrientations()
        if DeviceConstant.is_iPhoneOriPod{
            return .Portrait
        }else{
            return .All
        }
    }
}



struct DeviceConstant {


    static var is_iPhoneOriPod : Bool{
        return UIDevice.currentDevice().userInterfaceIdiom == .Phone
    }}