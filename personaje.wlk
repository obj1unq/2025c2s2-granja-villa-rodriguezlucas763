import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method mover(direccion) {
	  direccion.siguiente(position)
	}
    method validarSembrar() {
      if (self.hayPlantaAca()) {
        self.error("No puedo sembrar sobre otra planta")
      }
    }
    method hayPlantaAca() {
      return game.colliders(self) != []
    }
    method sembrar(planta) {
      self.validarSembrar()
      planta.fueSembradaEn(self.position())
    }
    method validarRegar() {
      if (not self.hayPlantaAca()) {
        self.error("No hay plantas para regar acá")
      }
    }
    method regar() {
      self.validarRegar()
      const planta = game.uniqueCollider(self)
      planta.fueRegada()
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