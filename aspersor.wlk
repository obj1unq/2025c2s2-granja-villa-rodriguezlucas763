import wollok.game.*
class Aspersor {
  var property position

	method esAspersor() {
	  return true
	}
  method image() {
    return "aspersor.png"
  }
  method regar(plantasDeAlrededor) {
    plantasDeAlrededor.forEach({cadaPlanta => cadaPlanta.fueRegada()})
  }
}

object aspersor {

  method fueColocadoEn(posicion) {
    const nuevoAspersor = new Aspersor(position = posicion)
	  game.addVisual(nuevoAspersor)
  }
}

