import personaje.*
import wollok.game.*


class Mercado {
  var property position
  var property cantMonedas 
  var property mercaderia

  method image() {
    return "market.png"
  }
  method vender(plantas) {
    const valorDeLasPlantas = plantas.sum({cadaPlanta => cadaPlanta.valorDeVenta()})

    if (valorDeLasPlantas <= cantMonedas) {
        mercaderia.addAll(plantas)
        self.pagar(valorDeLasPlantas)
        personaje.lasPlantasFueronVendidas()
        game.say(self, "Gracias! Vuelva prontos!")
    }
    else {
        self.error("No contamos con tantas monedas")
    }
  }
  method pagar(cantidadDeMonedas) {
    personaje.recibirPago(cantidadDeMonedas)
    cantMonedas -= cantidadDeMonedas
  }
}
