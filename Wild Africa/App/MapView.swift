//
//  MapView.swift
//  Wild Africa
//
//  Created by Sourabh Gapate on 16/05/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.437799)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        return mapRegion
    }()
    
    let locations: [NationalParkLocation] = Bundle.main.decode("locations.json")
    
    var body: some View {
        // MARK: - Basic Map
        // Map(coordinateRegion: $region)
        
        // MARK: - Advanced Maps (with Annotations)
        Map(coordinateRegion: $region, annotationItems: locations) { item in
            // (A) PIN: Old Style (always static)
            // MapPin(coordinate: item.location, tint: .accentColor)
            
            // (B) MARKER: New Style (always static)
            // MapMarker(coordinate: item.location, tint: .accentColor)
            
            // (C) CUSTOM BASIC ANNOTATION
            // MapAnnotation(coordinate: item.location) {
            // Image("logo")
            //    .resizable()
            //    .scaledToFit()
            //    .frame(width: 32, height: 32)
            
            // (D) CUSTOM ADVANCED ANIMATION
            MapAnnotation(coordinate: item.location) {
                MapAnnotationView(location: item)
            }
            
        }//: MAP
        .overlay(
            HStack(alignment: .center, spacing: 12) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48, alignment: .center)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                       Text("Latitude:")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    Divider()
                    HStack {
                       Text("Longitude:")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
            }//: HStack
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                Color.black
                    .cornerRadius(8)
                    .opacity(0.6)
            )
            .padding()
            , alignment: .top
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
