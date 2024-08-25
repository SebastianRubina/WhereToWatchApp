//
//  OnboardingView.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    var countryService = CountryService()
    
    @State var countryList = [Country]()
    @AppStorage("selectedCountry") var selectedCountry: String = "us"
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(.circle)
                
                Text("Where to Watch!")
                    .foregroundStyle(.orange)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                Text("To continue, select your country of residence from the list below.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.black.opacity(0.5))
                    Picker("Country", selection: $selectedCountry) {
                        ForEach(countryList, id: \.code) { country in
                            Text("\(country.emoji) \(country.name)")
                                .tag(country.code)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.white)
                    .buttonStyle(.bordered)
                }
                .frame(width: 240, height: 40)
                .padding(.top, 20)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.blue)
                        Text("Continue")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .bold()
                    }
                    .frame(width: 240, height: 60)
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
        }
        .onAppear {
            countryList = countryService.getCountries()
        }
    }
}

#Preview {
    OnboardingView()
}
