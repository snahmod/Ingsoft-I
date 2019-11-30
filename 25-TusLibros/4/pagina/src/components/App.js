
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
<<<<<<< HEAD
      catalog: new Array(),
      carrito: { items: new Array(), cartID: 0 },
      bookIndex: 0,
      userCredentials: {userID: '', password: ''},
      purchases: { items: [], total_amount: 0 }
=======
      catalog: {},
      carrito: { items: {}, cartID: 0 },
      emptyCarrito: { items: {}, cartID: 0 },
      bookIsbn: 0,
>>>>>>> 0e40140ec4a2ce0f7f1fd88f3f73aa6facf66d75
    };
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
        self.setState({ ...self.state, catalog: newCatalog, carrito: newCarrito, emptyCarrito: newCarrito })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  getPurchases(){
    var self = this;
    listPurchases(this.state.userCredentials.userID, this.state.userCredentials.password, 
                     (data) => {
                      self.setState({ ...self.state, purchases: data})
    })
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
      emptyCart: () => {
<<<<<<< HEAD
        const emptyItems = this.state.carrito.items.map(item => { return {isbn: item.isbn, quantity: 0} })
        this.setState({ ...this.state, carrito: { items: emptyItems, cartID: 0 }})
      }, 

      setUserCredentials: (userID, password) => {
        this.setState({ ...this.state, userCredentials: {userID: userID, password: password} })
=======
        this.setState({ ...this.state, carrito: this.state.emptyCarrito })
>>>>>>> 0e40140ec4a2ce0f7f1fd88f3f73aa6facf66d75
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
      this.getPurchases()
      content = (<CatalogView
        router={router}
        catalog={this.state.purchases}
        carrito={this.state.carrito}
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
