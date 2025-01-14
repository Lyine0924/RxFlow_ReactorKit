//
//  LoginService.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import Foundation
import RxSwift

enum UserLogin {
    static let didLogin = "didLogin"
}

protocol LoginServiceType: class {
    func setUserLogin()
    func setUserLogout()

    var didLoginObservable: Observable<Bool> { get }
    var didLogin: Bool { get }
}

final class LoginService: LoginServiceType {
    var defaults: UserDefaults
  
    init(defaults: UserDefaults) {
      self.defaults = defaults
    }
    
    var didLogin: Bool {
        return defaults.bool(forKey: UserLogin.didLogin)
    }
    
    var didLoginObservable: Observable<Bool> {
        return .just(didLogin)
    }
    
    func setUserLogin() {
        print("setUserLogin")

        defaults.set(true, forKey: UserLogin.didLogin)
    }
    
    func setUserLogout() {
        print("setUserLogout")
        
        defaults.removeObject(forKey: UserLogin.didLogin)
    }
}

// TODO: 이렇게 쓰면 안될 듯? 

extension LoginService: ReactiveCompatible {}

extension Reactive where Base: LoginService {
    var didLogin: Observable<Bool> {
        return UserDefaults.standard.rx
            .observe(Bool.self, UserLogin.didLogin)
            .map { $0 ?? false}
    }
}
