//
//  MainFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/03/31.
//

import UIKit
import NeedleFoundation
import RxFlow

protocol MainFlowDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol MainFlowComponentBuilder {
	var flow: Flow { get }
	var homeFlowBuilder: HomeFlowComponentBuilder { get }
	var middleFlowBuilder: MiddleFlowComponentBuilder { get }
	var settingFlowBuilder: SettingFlowComponentBuilder { get }
}

class MainFlowComponent: Component<MainFlowDependency>, MainFlowComponentBuilder {
	var flow: Flow {
		return MainFlow(dependency: self)
	}
	
	var homeFlowBuilder: HomeFlowComponentBuilder {
		return HomeFlowComponent(parent: self)
	}
	
	var middleFlowBuilder: MiddleFlowComponentBuilder {
		return MiddleFlowComponent(parent: self)
	}
	
	var settingFlowBuilder: SettingFlowComponentBuilder {
		return SettingFlowComponent(parent: self)
	}
}
