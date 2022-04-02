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

protocol MiddleDetailComponentBuilder {}

class MiddleDetailComponent: Component<MiddleDetailDependency>, MiddleDetailComponentBuilder {
	
}
