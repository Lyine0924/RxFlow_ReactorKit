//
//  ServiceProviderComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/03/28.
//

import Foundation
import NeedleFoundation

protocol ServiceProviderDependency: Dependency {
  var networkService: NetworkManagerType { get }
  var loginService: LoginServiceType { get }
}

protocol ServiceProviderBuilder {
  var provider: ServiceProviderType { get }
}

class ServiceComponent: Component<ServiceProviderDependency>, ServiceProviderBuilder {
  var provider: ServiceProviderType {
    return ServiceProviderImpl(networkService: self.networkService,
                               loginService: self.loginService)
  }
  
  deinit {
    print()
  }
}
