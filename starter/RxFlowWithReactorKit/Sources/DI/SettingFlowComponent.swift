//
//  SettingFlowComponent.swift
//  RxFlowWithReactorKit
//
//  Created by Lyine on 2022/04/02.
//

import Foundation
import NeedleFoundation

protocol SettingFlowDependency: Dependency {}

protocol SettingFlowComponentBuilder {}

class SettingFlowComponent: Component<SettingFlowDependency>, SettingFlowComponentBuilder {}
