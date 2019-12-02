class Carrrito {
  constructor() {
      this.items= {} 
      this.cartID =  0
      this.emptyCarrito = {}
  }

  setCartID(cartID) {
      this.cartID = cartID
  }

  setCartItems(items) {
    this.items = items
  }

  emptyCart() {
    this.setCartID(this.emptyCarrito.cartID)
    this.setCartItems(JSON.parse(JSON.stringify(this.emptyCarrito.items)))
  }

  setEmptyCart(emptyCart) {
    this.emptyCarrito = JSON.parse(JSON.stringify(emptyCart))
  }
}
