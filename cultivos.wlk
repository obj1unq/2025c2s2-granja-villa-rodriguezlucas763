import personaje.*
import wollok.game.*

class Maiz {
	var property position 
	var property esBebe = true

	method esPlanta() {
	  return true
	}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		if (esBebe) {
			return "corn_baby.png"
		}
		else return "corn_adult.png"
	}
	method fueRegada() {
		esBebe = false
	}
	method valorDeVenta() {
	  return 150
	}
}

class Trigo {
	var property position 
	var evolucion = 0
	var property esBebe = true

	method esPlanta() {
	  return true
	}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
	  	return "wheat_"+evolucion.toString()+".png"
	}
	method fueRegada() {
	  if (evolucion < 3) {
		evolucion += 1
	  }
	  else evolucion = 0
	  
	  if (evolucion >= 2) {
		esBebe = false
	  }
	}
	method valorDeVenta() {
	  return (evolucion - 1) * 100
	}
}

class Tomaco {
	var property position 
	var property esBebe = true

	method esPlanta() {
	  return true
	}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		if (esBebe) {
			return "tomaco_baby.png"
		}
		else return "tomaco.png"
	}
	method fueRegada() {
		self.validarSiHayPlantaArriba()
		esBebe = false

		if (not self.estoyEnElBorde()) {
			position = position.up(1) 
		}
		else position = game.at(position.x(), 0)
	}
	method estoyEnElBorde() {
	  return position.y() == game.height() - 1
	}
	method validarSiHayPlantaArriba() {
	  if (self.laProximaCeldaEstaDisponible()){
		self.error("No puedo regar porque hay algo arriba")
	  }
	}
	method laProximaCeldaEstaDisponible() {
	  return game.getObjectsIn(position.up(1)) != [] 
	}
	method valorDeVenta() {
	  return 80
	}
}

object maiz {
	method fueSembradaEn(posicion) {
	  const nuevoMaiz = new Maiz(position = posicion)
	  game.addVisual(nuevoMaiz)
	}
}
object trigo {
	method fueSembradaEn(posicion) {
	  const nuevoTrigo = new Trigo(position = posicion)
	  game.addVisual(nuevoTrigo)
	}
}
object tomaco {
	method fueSembradaEn(posicion) {
	  const nuevoTomaco = new Tomaco(position = posicion)
	  game.addVisual(nuevoTomaco)
	}
}