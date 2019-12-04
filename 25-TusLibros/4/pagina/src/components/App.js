

class App extends React.Component {

  constructor(props) {
    super(props);
    var carrito = new Carrrito();
    this.state = {
      path: '/',
      catalog: {},
      carrito: carrito,
      bookIsbn: 0,
      userCredentials: { userID: '', password: '' },
      purchases: { items: [], total_amount: 0 },
      error: ''
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

  setNavigateFalse() {
    this.setState({ ...this.state, path: {path: this.state.path.path, navigate: false}})
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

        var newCarrito = self.state.carrito
        newCarrito.items[data.isbn] = { isbn: data.isbn, quantity: 0 }
        newCarrito.setEmptyCart(JSON.parse(JSON.stringify(newCarrito)))
        self.setState({ ...self.state, catalog: newCatalog, carrito: newCarrito })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    let title = "Tus Libros"

    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        this.setState({ ...state, path: path})
      }
    }

    const reducedCatalog = {...this.state.catalog}
    Object.keys(this.state.catalog).forEach(isbn => {
      if (this.state.carrito.items[isbn].quantity == 0) delete reducedCatalog[isbn]
    })

    let routes = {
      '/': <LoginView router={router} carrito={this.state.carrito} />,
      '/catalog': <CatalogView router={router} catalog={this.state.catalog} carrito={this.state.carrito}/>,
      '/cart': 
          <div>
            <CatalogView router={router} catalog={reducedCatalog} carrito={this.state.carrito}/>
            <CarritoView router={router} reducedCatalog={reducedCatalog}/>
          </div>,
      '/book': <BookView router={router} bookIsbn={this.state.bookIsbn} catalog={this.state.catalog} carrito={this.state.carrito}/>,
      '/listPurchases': <PurchasesView router={router} catalog={this.state.catalog} userCredentials={this.state.userCredentials}/>,
      '/checkout': <CheckoutView router={router} catalog={this.state.catalog} carrito={this.state.carrito} userCredentials={this.state.userCredentials}/>,
      '/error': <ErrorView router={router} error={this.state.error} carrito = {this.state.carrito}/>
    }

    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
        />
        <Container maxWidth="md">
          <div style={{ marginTop: 20, }}>
            {routes[this.state.path]}
          </div>
        </Container>
      </div>
    );
  }
}