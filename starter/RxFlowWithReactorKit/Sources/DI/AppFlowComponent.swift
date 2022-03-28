//
//  AppFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/03/28.
//

import UIKit
import NeedleFoundation
import RxFlow

protocol AppFlowDependency: Dependency {
  var window: UIWindow { get }
  var serviceBuilder: ServiceProviderBuilder { get }
}

protocol AppFlowComponentBuilder {
  var flow: Flow { get }
  var stepper: Stepper { get }
}

class AppFlowComponent: Component<AppFlowDependency>, AppFlowComponentBuilder {
  var flow: Flow {
    return AppFlow(with: self.window, and: self.serviceBuilder.provider)
  }
  
  var stepper: Stepper {
    return AppStepper(provider: self.serviceBuilder.provider)
  }
}
