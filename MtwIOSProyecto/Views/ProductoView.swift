//
//  ProductoView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 20/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct ProductoView: View {
    var producto : ResultProductos
    var body: some View {
        HStack{
            ImageView(url: producto.thumbnail).overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            VStack(alignment: .leading){
                HStack{
                    Text(producto.nombre).font(.headline)
                    Spacer()
                    Text("$\(producto.dbCosto(), specifier: "%.2f")")
                }
                Text(producto.descripcion).font(.caption)
            }
        }
    }
}

struct ProductoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductoView(producto: ResultProductos.example)
    }
}
