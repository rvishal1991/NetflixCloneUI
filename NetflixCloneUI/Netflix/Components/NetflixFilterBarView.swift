//
//  NetflixFilterBarView.swift
//  NetflixCloneUI
//
//  Created by apple on 10/05/25.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title:String
    let isDropdown:Bool
    
    static var mockArray:[FilterModel]{
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false),
            FilterModel(title: "Categories", isDropdown: true)

        ]
    }
}

struct NetflixFilterBarView: View {
    
    var filters:[FilterModel] = FilterModel.mockArray
    var selectedFilter:FilterModel? = nil
    var onXmarkPressesd: (() -> Void)? = nil
    var onFilterPressesd: ((FilterModel) -> Void)? = nil

    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGrey)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onXmarkPressesd?()
                        }
                        .transition(AnyTransition(.move(edge: .leading)))
                        .padding(.leading, 16)
                }
                
                
                ForEach(filters, id: \.self){ filter in
                    
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropDown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressesd?(filter)
                        }
                        .padding(.leading, (selectedFilter == nil && filter == filters.first) ? 16 : 0)
                    }
                   
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}


fileprivate struct NetflixFilterBarPreview: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View{
        NetflixFilterBarView(
            filters: filters,
            selectedFilter: selectedFilter) {
                selectedFilter = nil
            } onFilterPressesd: { newFilter in
                selectedFilter = newFilter
            }

    }
    
}
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        NetflixFilterBarPreview()
    }
}
