//
//  NetflixMovieDetailsView.swift
//  NetflixCloneUI
//
//  Created by apple on 13/05/25.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMovieDetailsView: View {
    
    @Environment(\.router) var router

    var product:Product = .mock
    @State private var progress:Double = 0.3
    @State private var isMyList:Bool = false
    @State private var products:[Product] = []
    
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGrey.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing:0) {
                
                NetflixDetailHeaderView(
                    imageName: product.firstImage,
                    progress: progress) {
                        
                    } onXMarkPressed: {
                        router.dismissScreen()
                    }
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing:16) {
                        detailProductSection
                        buttonSection
                        productsGridSection
                    }
                    .padding(8)
                    
                }
                .scrollIndicators(.hidden)
                
            }
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    func getData() async  {
        guard products.isEmpty else { return  }
        do{
            self.products = try await Array(DatabaseHelper().getProducts())
        }catch{
        }
    }
    
    private var detailProductSection: some View {
        NetflixDetailsProductView(
            title: product.title ?? "",
            isNew: true,
            yearReleased: "2021",
            seasons: 4,
            hasClosedCaption: true,
            isTopTen: 6,
            descriptionText: product.description ?? "",
            castText: "Cast: Vishal, Kiaan and Nick") {
                
            } onDownloadPressed: {
                
            }
    }
    
    private var buttonSection: some View {
        HStack (spacing: 32){
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { selection in
                
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
    }
    
   private var productsGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                alignment: .center,
                spacing: 8,
                pinnedViews: []) {
                    ForEach(products) { product in
                        NetflixMovieCell(
                            imageName: product.firstImage,
                            title: product.title ?? "",
                            isRecentlyAdded: product.recentlyAdded,
                            topTenRanking: nil
                        )
                        .onTapGesture {
                            router.showScreen(.sheet) { _ in
                                NetflixMovieDetailsView(product: product)
                            }
                        }
                    }
                }
        }
        .foregroundStyle(.netflixWhite)
    }
    
}

#Preview {
    RouterView { _ in
        NetflixMovieDetailsView()
    }
}
