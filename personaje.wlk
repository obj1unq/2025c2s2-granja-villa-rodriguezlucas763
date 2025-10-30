import wollok.game.*
import cultivos.*
import aspersor.*

object personaje {
	var property position = game.center()
  const plantasSembradas = #{}
  const almacen = []
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
    plantasSembradas.add(position)                   //Guardo las posiciones donde sembré una planta
    planta.fueSembradaEn(self.position())
  }

  // REGAR -----------------------------------------------------
  method hayPlantaAca() {                                     //  Verifica que:
    return !game.colliders(self).isEmpty()                    //-La celda no esta vacía (posiblemente innecesario si borro la posicion al cosechar)
        && plantasSembradas.contains(self.position())         //-En esta posicion puse anteriormente una planta
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

    plantasSembradas.remove(position)
    almacen.add(game.uniqueCollider(self))    
    game.removeVisual(game.uniqueCollider(self))
    
  }

  // VENDER -----------------------------------------------------
  method vender() {
    almacen.forEach({cadaPlanta => dineroDeVentas += cadaPlanta.valorDeVenta()})
    almacen.clear()
  }
  method mostrarInterfaz() {
    game.say(self, "Tengo " + dineroDeVentas + " monedas y " 
                  + almacen.size() + " plantas para vender.")
  }

  // COLOCAR ASPERSOR -----------------------------------------------------
  method validarColocarAspersor() {
    if(!self.laCeldaEstaDisponible()) {
      self.error("No puedo colocar el aspersor")
    }
  }
  method colocarAspersor() {
    self.validarColocarAspersor()
    aspersor.fueColocadoEn(self.position())
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