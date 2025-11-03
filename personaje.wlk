import wollok.game.*
import cultivos.*
import aspersor.*

object personaje {
	var property position = game.center()
  const plantasSembradas = []
  const mercadosDeLaZona = []
  const plantasDelAlmacen = []
  var dineroDeVentas = 0

  // PERSONAJE -----------------------------------------------------
  method mover(direccion) {
    direccion.siguiente(position)
  }
  method image() {
    return "fplayer.png"
  }

  // SEMBRAR -----------------------------------------------------
  method validarSembrar() {
    if (!self.laCeldaEstaDisponible()) {
      self.error("No puedo sembrar sobre otras cosas")
    }
  }
  method laCeldaEstaDisponible() {
    return game.colliders(self).isEmpty()                   //Verifica que la celda está vacia, sin contar al personaje
  }
  method sembrar(planta) {
    self.validarSembrar()
    self.recordarPlanta(position)                                   //Guardo las posiciones donde sembré una planta
    planta.fueSembradaEn(position)
  }
  method recordarPlanta(posicion) {
    plantasSembradas.add(posicion)
  }
  method olvidarPlanta(posicion) {
    plantasSembradas.remove(posicion)
  }

  // REGAR -----------------------------------------------------
  method hayPlantaAca() {                                             //  Verifica que:
    return !game.colliders(self).isEmpty()                            //-La celda no esta vacía (posiblemente innecesario si borro la posicion al cosechar)
        && plantasSembradas.contains(position)                        //-En esta posicion puse anteriormente una planta
  }
  method validarSiHayPlanta() {
    if (!self.hayPlantaAca()) {
      self.error("No hay planta acá.")
    }
  }
  method regar() {
    self.validarSiHayPlanta()
    game.uniqueCollider(self).fueRegada()
  }

  // COSECHAR -----------------------------------------------------
  method validarCosechar() {
    if (self.laPlantaNoEstaLista()) {
      self.error("La planta no esta lista para cosechar.")
    }
  }
  method laPlantaNoEstaLista() {
    return game.uniqueCollider(self).esBebe()
  }
  method cosechar() {
    self.validarSiHayPlanta()
    self.validarCosechar()

    self.olvidarPlanta(position)
    plantasDelAlmacen.add(game.uniqueCollider(self))    
    game.removeVisual(game.uniqueCollider(self))
    
  }

  // VENDER -----------------------------------------------------
  method vender() {
    self.validarEstoyEnElMercado()
    self.validarSiTengoParaVender()
    const mercadoActual = game.getObjectsIn(position.up(1)).first()
    mercadoActual.vender(plantasDelAlmacen)
  }
  method lasPlantasFueronVendidas() {
    plantasDelAlmacen.clear()
  }
  method recibirPago(cantMonedas) {
    dineroDeVentas += cantMonedas
  }
  method mostrarInterfaz() {
    game.say(self, "Tengo " + dineroDeVentas + " monedas y " 
                  + plantasDelAlmacen.size() + " plantas para vender.")
  }
  method validarEstoyEnElMercado() {
    if (!self.estoyEnElMercado()) {
      self.error("No estoy en el mercado")
    }
  }
  method estoyEnElMercado() {
    return mercadosDeLaZona.contains(position.up(1))
  }
  method validarSiTengoParaVender() {
    if( plantasDelAlmacen.isEmpty() ) {
      self.error("No tengo plantas para vender.")
    }
  }
  method conocerMercado(mercado) {
    mercadosDeLaZona.add(mercado.position())
  }

  // COLOCAR ASPERSOR -----------------------------------------------------
  method validarColocarAspersor() {
    if(!self.laCeldaEstaDisponible()) {
      self.error("No puedo colocar el aspersor")
    }
  }
  method colocarAspersor() {
    self.validarColocarAspersor()
    aspersor.fueColocadoEn(position)
  }
}

// DIRECCIONES
object izquierda{
    method siguiente(position){
        return if (position.x() - 1 >= 0){
            position.left(1)
        }
        else position
    }
}
object derecha{
    method siguiente(position){
        return if (position.x() + 1 <= game.width() - 1){
            position.right(1)
        }
        else position
    }
}
object arriba{
    method siguiente(position){
        return if (position.y() + 1 <= game.height() - 1){
            position.up(1)
        }
        else position
    }
}
object abajo{
    method siguiente(position){
        return if (position.y() - 1 >= 0){
            position.down(1)
        }
        else position
    }
}