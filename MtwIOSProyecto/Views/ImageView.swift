 //
//  ImageView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 20/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var requestImagen: RequestImagen
    init(url: String?) {
        //print("Url de la imagen \(url!)")
        requestImagen = RequestImagen(url: url)
    }
    static var defaultImage = UIImage(named: "defaultImage")
    var body: some View {
        Image(uiImage: requestImagen.imagen ?? ImageView.defaultImage!)
            .resizable().scaledToFit().frame(width:90, height: 90)
    }
}
struct ImageDBView: View {
    @ObservedObject var requestImagen: RequestImagen
    init(url: String?) {
        //print("Url de la imagen \(url!)")
        requestImagen = RequestImagen(url: url)
    }
    static var defaultImage = UIImage(named: "defaultImage")
    var body: some View {
        Image(uiImage: requestImagen.imagen ?? ImageView.defaultImage!)
            .resizable().scaledToFit().frame(width:50, height: 50)
    }
}
 struct ImageDetailView: View {
     @ObservedObject var requestImagen: RequestImagen
     init(url: String?) {
         //print("Url de la imagen \(url!)")
         requestImagen = RequestImagen(url: url)
     }
     static var defaultImage = UIImage(named: "defaultImage")
     var body: some View {
         Image(uiImage: requestImagen.imagen ?? ImageView.defaultImage!)
             .resizable().scaledToFit()//.frame(width:300, height: 300)
     }
 }

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: nil)
    }
}
