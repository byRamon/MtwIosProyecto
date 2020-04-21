//
//  MainView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 21/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var orden: Orden
    var body: some View {
        TabView{
            ContentView().tabItem{
                Image(systemName: "bag")
                Text("Tiendas")
            }
            PedidoView().tabItem{
                Image(systemName: orden.productos.count > 0 ? "cart.fill" : "cart")
                Text("Ordenar")
            }
            PedidosView().tabItem{
                Image(systemName: orden.productos.count > 0 ? "cart.fill" : "cart")
                Text("Pedidos")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static let orden = Orden()
    static var previews: some View {
        MainView().environmentObject(orden)
    }
}
