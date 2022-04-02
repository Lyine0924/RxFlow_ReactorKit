//
//  RootComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/03/28.
//

import UIKit
import NeedleFoundation

class RootComponent: BootstrapComponent {
	
  var userDefaults: UserDefaults {
    return UserDefaults.standard
  }
  
  var networkService: NetworkManagerType {
    shared {
      NetworkManager()
    }
  }
  
  var loginService: LoginServiceType {
    shared {
      LoginService(defaults: self.userDefaults)
    }
  }
  
  var serviceBuilder: ServiceProviderBuilder {
    shared {
      ServiceComponent(parent: self)
    }
  }
  
  var appFlowBuilder: AppFlowComponentBuilder {
    shared {
      AppFlowComponent(parent: self)
    }
  }
}
