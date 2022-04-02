//
//  MiddleComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol MiddleDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol MiddleComponentBuilder {
	var viewController: MiddleViewController { get }
}

class MiddleComponent: Component<MiddleDependency>, MiddleComponentBuilder {
	var viewController: MiddleViewController {
		let reactor = MiddleReactor(provider: self.dependency.serviceBuilder.provider)
		return MiddleViewController(with: reactor)
	}
}
