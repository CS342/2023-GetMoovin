//
// This source file is part of the CS342 2023 GetMoovin Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import Account
import Onboarding
import SwiftUI


struct GetMoovinSignUp: View {
    var body: some View {
        SignUp {
            IconView()
                .padding(.top, 32)
            Text("SIGN_UP_SUBTITLE", bundle: .module)
                .multilineTextAlignment(.center)
                .padding()
            Spacer(minLength: 0)
        }
            .navigationBarTitleDisplayMode(.large)
    }
}


#if DEBUG
struct GetMoovinSignUp_Previews: PreviewProvider {
    static var previews: some View {
        GetMoovinSignUp()
            .environmentObject(Account(accountServices: []))
    }
}
#endif
