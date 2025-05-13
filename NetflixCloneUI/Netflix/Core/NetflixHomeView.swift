//
//  NetflixHomeView.swift
//  NetflixCloneUI
//
//  Created by apple on 10/05/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    
    @Environment(\.router) var router

    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = 0

    @State private var heroProduct: Product? = nil
    @State private var currentUser:User? = nil
    @State private var productRows:[ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            
            scrollViewLayer
            
            fullHeaderViewFilter
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    
    func getData() async  {
        guard productRows.isEmpty else { return  }
        do{
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await Array(DatabaseHelper().getProducts())
            heroProduct = products.randomElement()
            var rows:[ProductRow] = []
            
            let allBrands = Set(products.map { $0.brand ?? "" })
             
            for brand in allBrands{
//                let products = self.products.filter { $0.brand ?? "" == brand }
                rows.append(ProductRow(title: brand.capitalized, products: products.shuffled()))
            }
            productRows = rows
        }catch{
        }
    }
    
    private func onProductPressed(product:Product){
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailsView(product: product)
        }
    }
    
    private var header:some View{
        
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
        
    }
    
    private func heroCell(product:Product) -> some View{
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title ?? "",
            categories: [product.category?.capitalized ?? "", product.brand ?? ""]) {
                onProductPressed(product: product)
            } onPlayPressed: {
                onProductPressed(product: product)
            } onMyListPressed: {
                
            }
            .padding(24)
    }
    
    
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixDarkGrey.opacity(1), .netflixDarkGrey.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [.netflixDarkRed.opacity(1), .netflixDarkRed.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffset * 0.75)))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false) {
                VStack(spacing:8){
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                   
                    if let heroProduct{
                        heroCell(product: heroProduct)
                    }
                    categoryRows
                }
            } onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            }
    }
    
    private var fullHeaderViewFilter: some View {
        VStack(spacing:16){
            header
                .padding(.horizontal, 16)
           
            if scrollViewOffset > -20{
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) {
                        selectedFilter = nil
                    } onFilterPressesd: { newFilter in
                        selectedFilter = newFilter
                    }
                    .padding(.top, 16)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
        }
        .padding(.bottom, 8)
        .background(
            ZStack{
                if scrollViewOffset < -70{
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    private var categoryRows:some View{
        LazyVStack(spacing:16){
            ForEach(Array(productRows.enumerated()), id: \.offset){ (rowIndex, row) in
                VStack(alignment: .leading, spacing:  8 ) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal) {
                        LazyHStack{
                            ForEach(Array(row.products.enumerated()), id: \.offset){ (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title ?? "",
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? index + 1 : nil
                                )
                                .onTapGesture {
                                    onProductPressed(product: product)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        NetflixHomeView()
    }
}
