import personaje.*
import wollok.game.*

class Maiz {
	var position 
	var esBebe = true

	method position() {
		return position
	}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		if (esBebe) {
			return "corn_baby.png"
		}
		else return "corn_adult.png"
	}
	method fueRegada() {
	  if (esBebe) {
		esBebe = not esBebe
	  }
	}
}

class Trigo {
	var position 
	var evolucion = 0

	method position() {
	  	return position
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
	}
}

class Tomaco {
	var position 

	method position() {
	  	return position
	}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
	  	return "tomaco_baby.png"
	}
	method fueRegada() {
		self.validarSiHayPlantaArriba()
		if (not self.estoyEnElBorde()) {
			position = position.up(1) 
		}
		else position = position.y()
	}
	method estoyEnElBorde() {
	  return position.y() == game.height()
	}
	method validarSiHayPlantaArriba() {
	  if (self.hayUnaPlantaArriba()){
		self.error("No puedo regar porque hay una planta arriba")
	  }
	}
	method hayUnaPlantaArriba() {
	  
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