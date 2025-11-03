import personaje.*
import wollok.game.*
class Aspersor {
  var property position
  const direcciones = [norte, sur, este, oeste, norOeste, surOeste, norEste, surEste]

  method image() {
    return "aspersor.png"
  }
  method fueRegada(){}
  method encenderAspersor() {
    direcciones
      .map({dir => dir.direccion(position)})
      .filter({pos => self.hayPlantaEn(pos)})
      .forEach({pos => self.plantaEn(pos).fueRegada()})
  }
  method hayPlantaEn(posicion) {
    return personaje.hayPlantaAca(posicion)
  }
  method plantaEn(posicion) {
    return game.getObjectsIn(posicion).first()
  }
}

object aspersor {
  method fueColocadoEn(posicion) {
    const nuevoAspersor = new Aspersor(position = posicion)
	  game.addVisual(nuevoAspersor)
    game.onTick(1000, "regar constantemente", {nuevoAspersor.encenderAspersor()})
  }
}

object norte {
  method direccion(posicion) {return posicion.up(1)}
}
object sur {
  method direccion(posicion) {return posicion.down(1)}
}
object este {
  method direccion(posicion) {return posicion.right(1)}
}
object oeste {
  method direccion(posicion) {return posicion.left(1)}
}

object norOeste {
  method direccion(posicion) {return posicion.up(1).left(1)}
}
object surOeste {
  method direccion(posicion) {return posicion.down(1).left(1)}
}
object norEste {
  method direccion(posicion) {return posicion.up(1).right(1)}}
object surEste {
  method direccion(posicion) {return posicion.down(1).right(1)}
}
