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
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol AppFlowComponentBuilder {
	var flow: AppFlow { get }
	var stepper: Stepper { get }
	var loginBuidler: LoginFlowComponentBuilder { get }
	var mainBuilder: MainFlowComponentBuilder { get }
}

class AppFlowComponent: Component<AppFlowDependency>, AppFlowComponentBuilder {
	var flow: AppFlow {
		return AppFlow(dependency: self)
	}
	
	var stepper: Stepper {
		return AppStepper(provider: self.serviceBuilder.provider)
	}
	
	var loginBuidler: LoginFlowComponentBuilder {
		return LoginFlowComponent(parent: self)
	}
	
	var mainBuilder: MainFlowComponentBuilder {
		return MainFlowComponent(parent: self)
	}
}
