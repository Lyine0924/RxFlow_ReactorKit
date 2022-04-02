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
	var homeFlowBuilder: HomeFlowComponenetBuilder { get }
	var middleFlowBuilder: MiddleFlowComponentBuilder { get }
}

class MainFlowComponent: Component<MainFlowDependency>, MainFlowComponentBuilder {
	var flow: Flow {
		return MainFlow(dependency: self)
	}
	
	var homeFlowBuilder: HomeFlowComponenetBuilder {
		return HomeFlowComponenet(parent: self)
	}
	
	var middleFlowBuilder: MiddleFlowComponentBuilder {
		return MiddleFlowComponent(parent: self)
	}
}
