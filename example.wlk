class Hogar {
  var mugre
  const confort

  method esBueno() = mugre <= confort * 0.5
  method recibirAtaque(plaga) {
    mugre = mugre + plaga.nivelDeDanio()
  }
}

class Mascota {
  var salud

  method esBueno() = salud > 250
  method recibirAtaque(plaga) {
    if(plaga.transmiteEnfermedades()) salud = 0.max(salud - plaga.nivelDeDanio())
  }
}

class Huerta {
  var produccion
  method recibirAtaque(plaga) {
    produccion = 
    0.max(produccion - plaga.nivelDeDanio() * 0.1 + if(plaga.transmiteEnfermedades()) 10 else 0)
  }
  method esBueno() = nivelMinimoDeProduccion.valor() < produccion
}

object nivelMinimoDeProduccion {
  var property valor = 2000
}

class Barrio {
  const property elementos = []

  method esCopado() = self.elementosBuenos() > self.elementosNoBuenos()

  method elementosBuenos() = elementos.count({e=>e.esBueno()})
  method elementosNoBuenos() = elementos.count({e=>!e.esBueno()})

}

class Plaga {
  var poblacion
  method poblacion() = poblacion
  method transmiteEnfermedades() = poblacion >= 10
  method atacar(elemento) {
    elemento.recibirAtaque(self)
    self.efectoDelAtaque()
  }
  method efectoDelAtaque() {poblacion = poblacion * 1.1}
}
class Cucarachas inherits Plaga {
  var pesoPromedio
  method nivelDeDanio() = poblacion * 0.5
  override method transmiteEnfermedades() = super() && pesoPromedio >= 10
  override method efectoDelAtaque() {
    super()
    pesoPromedio += 2
    }
}

class Pulgas inherits Plaga {
  method nivelDeDanio() = poblacion * 2
}

class Garrapatas inherits Pulgas {
  override method efectoDelAtaque() {poblacion = poblacion * 1.2}
}

class Mosquitos inherits Plaga {
  method nivelDeDanio() = poblacion
  override method transmiteEnfermedades() = super() && poblacion % 3 == 0
}

