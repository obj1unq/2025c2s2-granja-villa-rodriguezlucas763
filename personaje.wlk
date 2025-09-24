import wollok.game.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method mover(direccion) {
	  direccion.siguiente(position)
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