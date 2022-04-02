//
//  SettingFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol SettingFlowDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol SettingFlowComponentBuilder {
	var flow: SettingFlow { get }
	var builder: SettingComponentBuilder { get }
}

class SettingFlowComponent: Component<SettingFlowDependency>, SettingFlowComponentBuilder {
	var flow: SettingFlow {
		return SettingFlow(dependency: self, stepper: .init())
	}
	
	var builder: SettingComponentBuilder {
		return SettingComponent(parent: self)
	}
}
