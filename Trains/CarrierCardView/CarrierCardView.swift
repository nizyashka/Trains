import SwiftUI

struct CarrierCardView: View {
    @Binding var path: [Route]
    let carrier: CarrierInfo
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: carrier.logo)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 343, height: 104)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()

                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 50)

                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(width: 343, height: 104)
                
                Text(carrier.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.accent)
                
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.accent)
                    
                    Text(carrier.email)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.accent)
                    
                    Text(carrier.phone)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.blue)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.accent)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
        }
    }
}
