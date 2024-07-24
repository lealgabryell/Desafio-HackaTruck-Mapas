//
//  ContentView.swift
//  DesafioMapa
//
//  Created by Turma01-17 on 17/07/24.
//
import MapKit
import Foundation

import SwiftUI


var auxLocation : Location =  Location(nome:"", bandeira:"", descricao: "", coordinates:CLLocationCoordinate2D(latitude: 0, longitude:0))


struct Location : Identifiable{
    var id = UUID()
    var nome : String
    var bandeira: String
    var descricao : String
    var coordinates : CLLocationCoordinate2D
}

struct ContentView: View {
    
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -14.2350, longitude: -51.9253),
            span:MKCoordinateSpan(latitudeDelta:60,longitudeDelta:1))
    )

    var arrayLocations = [
        Location(nome:"Brazil", bandeira:"https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png", descricao: "Brazil contains most of the Amazon River basin, which has the world's largest river system and the world's most-extensive virgin rainforest. The country contains no desert, high-mountain, or arctic environments. Brazil is the fifth most-populous country on Earth and accounts for one-third of Latin America's population.", coordinates:CLLocationCoordinate2D(latitude: -14.2350, longitude:-51.9253)),
        
        Location(nome:"United States", bandeira:"https://cdn.britannica.com/79/4479-050-6EF87027/flag-Stars-and-Stripes-May-1-1795.jpg", descricao: "The United States of America is the world's third largest country in size and nearly the third largest in terms of population. Located in North America, the country is bordered on the west by the Pacific Ocean and to the east by the Atlantic Ocean. Along the northern border is Canada and the southern border is Mexico.", coordinates:CLLocationCoordinate2D(latitude: 37.6, longitude:-95.665)),
        
        Location(nome:"South Africa", bandeira:"https://s3.static.brasilescola.uol.com.br/be/2023/07/bandeira-da-africa-do-sul.jpg", descricao: "TSouth Africa, the southernmost country on the African continent, renowned for its varied topography, great natural beauty, and cultural diversity, all of which have made the country a favored destination for travelers since the legal ending of apartheid (Afrikaans: “apartness,” or racial separation) in 1994.", coordinates:CLLocationCoordinate2D(latitude: -28.4792625 , longitude:24.6727135))
    ]
    
    
    @State var locationNome : String = "Brazil"
    @State var showingSheet : Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Map(position: $position){
                    ForEach(arrayLocations){e in
                        Annotation("Details", coordinate: e.coordinates){
                            
                            VStack{
                                Image(systemName: "mappin.and.ellipse")
                            }.onTapGesture {
                                showingSheet = true
                                auxLocation = e
                            }
                            
                        }
                        
                    }
                } .sheet(isPresented: $showingSheet) {
                    VStack{
                        Text(auxLocation.nome)
                        AsyncImage(url: URL(string: auxLocation.bandeira)){
                            image in
                            image
                                .resizable()
                                .frame(width: 300, height: 200)
                                .scaledToFill()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        Text(auxLocation.descricao)
                    }
                    .padding()
                }
                .ignoresSafeArea()
                
                VStack(spacing: 600){
                    VStack{
                        Text("World Map")
                            .font(.title)
                            .bold()
                        Text(locationNome)
                            .font(.subheadline)
                    }
                    .frame(width: 400, height: 100)
                    .background(.white)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    
                    HStack(spacing: 30){
                        ForEach(arrayLocations, id: \.id){e in
                            Button{
                                locationNome = e.nome
                                auxLocation = e
                                position = MapCameraPosition.region(
                                    MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: e.coordinates.latitude, longitude: e.coordinates.longitude),
                                        span:MKCoordinateSpan(latitudeDelta:60,longitudeDelta:1))
                                )
                            }label: {
                                AsyncImage(url: URL(string: e.bandeira)){
                                    image in
                                    
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .scaledToFill()
                                        .frame(width: 80, height: 60)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        }.padding()
                    
                }
            }.tint(.black)
        }
    }
}



#Preview {
    ContentView()
}
