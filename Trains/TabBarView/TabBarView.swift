import SwiftUI
import OpenAPIURLSession

struct TabBarView: View {
    @Binding var isAppDarkMode: Bool
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "arrow.up.message.fill")
                }
            
            SettingsView(isAppDarkMode: $isAppDarkMode)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .tint(isAppDarkMode ? .white : Color.backgroundBlackStatic)
    }
}
