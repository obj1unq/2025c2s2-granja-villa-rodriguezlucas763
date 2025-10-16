import wollok.game.*
import cultivos.*
import aspersor.*

object personaje {
	var property position = game.center()
  const almacen = []
	const property image = "fplayer.png"
  var dineroDeVentas = 0

	method mover(direccion) {
	  direccion.siguiente(position)
	}
    method validarSembrar() {
      if (self.hayPlantaAca() || self.hayUnAspersor()) {
        self.error("No puedo sembrar sobre otras cosas")
      }
    }
    method hayPlantaAca() {
      return game.uniqueCollider(self).esPlanta()
    }
    method sembrar(planta) {
      self.validarSembrar()
      planta.fueSembradaEn(self.position())
    }
    method validarRegar() {
      if (not self.hayPlantaAca()) {
        self.error("No hay plantas para regar acá.")
      }
    }
    method regar() {
      self.validarRegar()
      const planta = game.uniqueCollider(self)
      planta.fueRegada()
    }
    method validarCosechar() {
      if (not self.hayPlantaAca()) {
        self.error("No hay planta para cosechar acá.")
      }
    }
    method validarCosechar2() {
      if (self.laPlantaNoEstaLista()) {
        self.error("La planta no esta lista para cosechar.")
      }
    }
    method laPlantaNoEstaLista() {
      return game.uniqueCollider(self).esBebe()
    }
    method cosechar() {
      self.validarCosechar()
      self.validarCosechar2()
      almacen.add(game.uniqueCollider(self))
      game.removeVisual(game.uniqueCollider(self))
    }
    method vender() {
      almacen.forEach({cadaPlanta => dineroDeVentas += cadaPlanta.valorDeVenta()})
      almacen.clear()
    }
    method mostrarInterfaz() {
      game.say(self, 
              "Tengo "+dineroDeVentas+ " monedas y " +almacen.size()+ " plantas para vender.")
    }
    method hayUnAspersor() {
      return game.uniqueCollider(self).esAspersor()
    }
    method validarColocarAspersor() {
      if(self.hayUnAspersor() || self.hayPlantaAca()) {
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