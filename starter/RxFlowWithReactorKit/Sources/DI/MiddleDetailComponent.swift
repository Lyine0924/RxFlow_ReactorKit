//
//  MiddleDetailComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol MiddleDetailDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol MiddleDetailComponentBuilder {
	var viewController: MiddleDetailViewContorller { get }
}

class MiddleDetailComponent: Component<MiddleDetailDependency>, MiddleDetailComponentBuilder {
	var viewController: MiddleDetailViewContorller {
		let reactor = MiddleDetailReactor(provider: self.dependency.serviceBuilder.provider)
		return MiddleDetailViewContorller(with: reactor)
	}
}
