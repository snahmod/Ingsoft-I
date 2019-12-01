
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      catalog: {},
      carrito: { items: {}, cartID: 0 },
      bookIsbn: 0,
      userCredentials: { userID: '', password: '' },
      purchases: { items: [], total_amount: 0 },
      error: ''
    };

    this.emptyCarrito = { items: {}, cartID: 0 }
  }

  componentWillMount() {
    this.getCatalog();
  }

  getCatalog(){
    var self = this;
    getLocalAsJson(`getCatalog`)
      .then(response => {
        if (response.ok) return response.json()
        throw Error('Oops')
      })
      .then(data => {
          data.forEach( function(value, index, array) {
            self.handleBook(value)
        });
      })
      .catch(error => console.log(error.message))
  }

  handleBook = data => {
    var self = this;
    getISBNApiAsJson(data.isbn)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        var newCatalog = {...self.state.catalog}
        var book = json[Object.keys(json)[0]]
        book["price"] = '$' + data.price
        book["isbn"] = data.isbn
        newCatalog[data.isbn] = book

        var newCarrito = {...self.state.carrito}
        newCarrito.items[data.isbn] = { isbn: data.isbn, quantity: 0 }
        self.emptyCarrito = JSON.parse(JSON.stringify(newCarrito))
        self.setState({ ...self.state, catalog: newCatalog, carrito: JSON.parse(JSON.stringify(newCarrito)) })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    let title = "Tus Libros"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        this.setState({ ...state, path: path })
      },
      setCart: (carrito) => {
        this.setState({ ...this.state, carrito: carrito })
      },
      setCartID: (cartID) => {
        this.setState({ ...this.state, carrito: {items: this.state.carrito.items, cartID: cartID }})
        console.log('carto:', this.state.carrito)
      },
      emptyCart: () => {
        this.setState({ ...this.state, carrito: JSON.parse(JSON.stringify(this.emptyCarrito)) })
        console.log('empty:', this.state.carrito)
      },
      setUserCredentials: (userID, password) => {
        this.setState({ ...this.state, userCredentials: { userID: userID, password: password } })
      }
    }

    if (this.state.path === "/") {
        content = (<LoginView
        router={router}
        carrito={this.state.carrito}
      />)
    } else if (this.state.path === "/catalog") {
        content = (<CatalogView
        router={router}
        catalog={this.state.catalog}
        carrito={this.state.carrito}
      />)
    } else if (this.state.path === "/cart") {
      const reducedCatalog = {...this.state.catalog}
      Object.keys(this.state.catalog).forEach(isbn => {
        if (this.state.carrito.items[isbn].quantity == 0) delete reducedCatalog[isbn]
      })
      content = ( <div>
      <CatalogView
        router={router}
        catalog={reducedCatalog}
        carrito={this.state.carrito}
      />
      <CarritoView
      router={router}
      reducedCatalog={reducedCatalog} />
      </div>
      )
    } else if (this.state.path === "/book") {
      content = (
      <BookView
        router={router}
        bookIsbn={this.state.bookIsbn}
        catalog={this.state.catalog}
        carrito={this.state.carrito}
      />
      )
    } else if (this.state.path === "/listPurchases") {
      content = (<PurchasesView
        router={router}
        catalog={this.state.catalog}
        userCredentials={this.state.userCredentials}
      />)
    } else if (this.state.path === "/checkout") {
      content = (<CheckoutView
        router={router}
        catalog={this.state.catalog}
        carrito={this.state.carrito}
        userCredentials={this.state.userCredentials}
      />)
    } else if (this.state.path === "/error") {
      content = (<ErrorView
        router={router}
        error={this.state.error}
      />)
    }

    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
        />
        <Container maxWidth="md">
          <div style={{ marginTop: 20, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
