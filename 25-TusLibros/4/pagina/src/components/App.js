

class App extends React.Component {

  constructor(props) {
    super(props);
    var carrito = new Carrrito();
    this.state = {
      path: {path: "/", navigate: false},
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
    let content = ""

    if (this.state.path.navigate) {
      //this.setNavigateFalse()
      return <ReactRouterDOM.Redirect to={this.state.path.path} />
    }

    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        this.setState({ ...state, path: {path: path, navigate: true}})
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
      content = ( <BookView
        router={router}
        bookIsbn={this.state.bookIsbn}
        catalog={this.state.catalog}
        carrito={this.state.carrito}
      /> )
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
        carrito = {this.state.carrito}
      />)
    }

    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          carrito={this.state.carrito}
        />
        
    <ReactRouterDOM.BrowserRouter>
     
        <ReactRouterDOM.Route path='/' 
          component={() => <LoginView
          router={router}
          carrito={this.state.carrito} /> }/>
        <ReactRouterDOM.Route path='/catalog' 
          component={() => <CatalogView
            router={router}
            catalog={this.state.catalog}
            carrito={this.state.carrito}
          /> }/>
        <ReactRouterDOM.Route path='/cart' 
          component={() => <CarritoView
          router={router}
          reducedCatalog={reducedCatalog} />}/>
        <ReactRouterDOM.Route path='/book' 
          component={() => <BookView
            router={router}
            bookIsbn={this.state.bookIsbn}
            catalog={this.state.catalog}
            carrito={this.state.carrito}
          /> }/>
        <ReactRouterDOM.Route path='/listPurchases' 
          component={() => <PurchasesView
            router={router}
            catalog={this.state.catalog}
            userCredentials={this.state.userCredentials}
          /> }/>
        <ReactRouterDOM.Route path='/checkout' 
          component={() => <CheckoutView
            router={router}
            catalog={this.state.catalog}
            carrito={this.state.carrito}
            userCredentials={this.state.userCredentials}
          /> }/>
        <ReactRouterDOM.Route path='/error' 
          component={() => <ErrorView
            router={router}
            error={this.state.error}
            carrito = {this.state.carrito}
          /> }/>
        
      </ReactRouterDOM.BrowserRouter>
      </div>
    );
  }
}