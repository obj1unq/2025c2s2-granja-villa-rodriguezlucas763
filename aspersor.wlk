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

/*object direcciones {
  var property position 

  method norte() = position.up(1)
  method sur()   = position.down(1)
  method este()  = position.right(1)
  method oeste() = position.left(1)

  
}
*/