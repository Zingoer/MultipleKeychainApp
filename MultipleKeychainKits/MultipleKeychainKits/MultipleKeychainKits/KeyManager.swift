//
//  File.swift
//  MultipleKeychainKits
//
//  Created by Xiaoxi Pang on 10/29/15.
//  Copyright © 2015 Zingoer. All rights reserved.
//

import Foundation

public class KeyManager{

    public var key: String{
        get{
            return fetchKey()
        }
    }
    
    public init(){
        
    }
    
    public func generateKey(){
        let myKeychainWrapper = KeychainItemWrapper(identifier: "com.mkck.def", accessGroup: nil)
        debugPrint("\(myKeychainWrapper)")
        debugPrint("Keychain AttrAccount: \(myKeychainWrapper.objectForKey(kSecAttrAccount)), Keychain Value: \(myKeychainWrapper.objectForKey(kSecValueData))")
        
        let key = "generatedKey".dataUsingEncoding(NSUTF8StringEncoding)
        debugPrint("Key prepares to save into the keychain: \(key)")
        // 
        myKeychainWrapper.setObject(key!, forKey: kSecValueData)
    }
    
    func fetchKey() -> String{
        let myKeychainWrapper = KeychainItemWrapper(identifier: "com.mkck.def", accessGroup: nil)
        
        let keyFromKC = myKeychainWrapper.objectForKey(kSecValueData) as? NSData
        debugPrint("KEY from keychain: \(keyFromKC)")
        let keyString = String(data: keyFromKC!, encoding: NSUTF8StringEncoding)
        
        return keyString!
    }
}