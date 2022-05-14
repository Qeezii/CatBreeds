//
//  BarChartsVView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct BarChartsVView: View {
    
    @ObservedObject var classifierViewModel: ClassifierViewModel
    
    var body: some View {
        
        ScrollView() {
            VStack {
                VStack {
                    
                    Spacer()
                        .frame(height:20)
                    
                    BarChartHView(
                        classifierViewModel: classifierViewModel)
                        .frame(width: 400, height: 450, alignment: .center)
                    
                    Spacer()
                        .frame(height:50)
                }
            }
        }
    }
}

struct BarChartsVView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartsVView(classifierViewModel: ClassifierViewModel())
    }
}
