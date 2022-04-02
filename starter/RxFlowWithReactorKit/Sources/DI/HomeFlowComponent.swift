//
//  HomeFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/03/31.
//

import UIKit
import NeedleFoundation
import RxFlow

protocol HomeFlowDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol HomeFlowComponentBuilder {
	var flow: HomeFlow { get }
	var homeBuilder: HomeComponentBuilder { get }
	var homeDetailBuilder: HomeDetailBuilder { get }
}

class HomeFlowComponent: Component<LoginFlowDependency>, HomeFlowComponentBuilder {
	var flow: HomeFlow {
		return HomeFlow(dependency: self, stepper: .init())
	}
	
	var homeBuilder: HomeComponentBuilder {
		return HomeComponenet(parent: self)
	}
	
	var homeDetailBuilder: HomeDetailBuilder {
		return HomeDetailComponent(parent: self)
	}
}

protocol HomeDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol HomeComponentBuilder {
	var homeViewController: HomeViewController { get }
}

class HomeComponenet: Component<HomeDependency>, HomeComponentBuilder {
	var homeViewController: HomeViewController {
		let reactor = HomeReactor(provider: self.dependency.serviceBuilder.provider)
		return HomeViewController(with: reactor)
	}
}

protocol HomeDetailDependency: Dependency {
	var serviceBuilder: ServiceProviderBuilder { get }
}

protocol HomeDetailBuilder {
	func makeDetailViewController(title: String) -> HomeDetatilViewController
}

class HomeDetailComponent: Component<HomeDetailDependency>, HomeDetailBuilder {
	func makeDetailViewController(title: String) -> HomeDetatilViewController {
		let reactor = HomeDetailReactor(provider: self.dependency.serviceBuilder.provider)
		return HomeDetatilViewController(with: reactor, title: title)
	}
}
