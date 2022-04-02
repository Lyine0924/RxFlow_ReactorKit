//
//  MiddleFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol MiddleFlowDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol MiddleFlowComponentBuilder {
	var flow: MiddleFlow { get }
	var middleBuilder: MiddleComponentBuilder { get }
}

class MiddleFlowComponent: Component<MiddleFlowDependency>, MiddleFlowComponentBuilder {
	var flow: MiddleFlow {
		return MiddleFlow(with: self, stepper: .init())
	}
	
	var middleBuilder: MiddleComponentBuilder {
		return MiddleComponent(parent: self)
	}
}
