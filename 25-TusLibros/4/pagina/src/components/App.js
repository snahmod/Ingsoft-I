
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      catalog: {},
      carrito: { items: {}, cartID: 0 },
      emptyCarrito: { items: {}, cartID: 0 },
      bookIsbn: 0,
    };

    // this.data = [
    //   {isbn: "0451526538", price: "$100"},
    //   {isbn: "0439358078", price: "$100"},
    //   {isbn: "0316015849", price: "$100"},
    // ];
  }

  componentWillMount() {
    this.getMyData();
  }

  getMyData(){
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
        this.setState({ ...this.state, carrito: this.state.emptyCarrito })
      }
    }

    if (this.state.path === "/") {
      content = (<LoginView
        router={router}
        carrito={this.state.carrito}
      />)
    } else if (this.state.path === "/catalog") {
      console.log(this.state.catalog)
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
