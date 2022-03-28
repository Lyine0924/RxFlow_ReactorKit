//
//  ServiceProvider.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//
import Foundation

protocol ServiceProviderType: AnyObject {
    var networkService: NetworkManagerType { get }
    var loginService: LoginServiceType { get }
    
}

final class ServiceProviderImpl: ServiceProviderType {
  let networkService: NetworkManagerType
  let loginService: LoginServiceType
  
  init(
    networkService: NetworkManagerType,
    loginService: LoginServiceType
  ) {
    self.networkService = networkService
    self.loginService = loginService
  }
}
