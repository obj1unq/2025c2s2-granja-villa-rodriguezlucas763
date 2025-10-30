import personaje.*
import wollok.game.*

class Maiz {
	var property position 
	var property esBebe = true

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

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
	  	return "wheat_"+evolucion.toString()+".png"
	}
	method fueRegada() {
		if (evolucion == 3) {
			evolucion = 0
		}
		else evolucion += 1

		esBebe = evolucion < 2
	}
	method valorDeVenta() {
	  return (evolucion - 1) * 100
	}
}

class Tomaco {
	var property position 
	const property esBebe = false

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		if (esBebe) {
			return "tomaco_baby.png"
		}
		else return "tomaco.png"
	}
	method fueRegada() {
		self.validarProximaCeldaLibre()

		if (not self.estoyEnElBorde()) {
			position = position.up(1) 
		}
		else position = game.at(position.x(), 0)
	}
	method estoyEnElBorde() {
	  return position.y() == game.height() - 1
	}
	method validarProximaCeldaLibre() {
	  if (not self.laProximaCeldaEstaDisponible()){
		self.error("No puedo regar, la proxima celda esta ocupada")
	  }
	}
	method laProximaCeldaEstaDisponible() {
	  if (not self.estoyEnElBorde()) {									//Si estoy en el borde:
		return game.getObjectsIn(self.position().up(1)).isEmpty()		//Me fijo que no haya nada arriba
	  }
	  else {															//Si no
		return game.getObjectsIn(game.at(position.x(), 0)).isEmpty()	//Me fijo que no haya nada abajo de todo (donde iría la planta)
	  }

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