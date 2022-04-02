//
//  SettingComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol SettingDependency: Dependency {}

protocol SettingComponentBuilder {}

class SettingComponent: Component<SettingDependency>, SettingComponentBuilder {}
