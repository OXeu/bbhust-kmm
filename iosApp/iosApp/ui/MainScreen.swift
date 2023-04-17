//
//  MainScreen.swift
//  iosApp
//
//  Created by xeu on 2023/3/2.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct MainScreen: View {
    let store = LoginReduxKt.store
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
