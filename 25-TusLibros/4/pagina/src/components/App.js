
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      substrings: [],
      selectedSubstring: "",
      catalog: new Array(),
      carrito: { items: new Array(), cartID: 0 },
      bookIndex: 0,
    };

    this.data = [
      {isbn: "0451526538", price: "$100"},
      {isbn: "0439358078", price: "$100"},
      {isbn: "0316015849", price: "$100"},
    ];
  }

  componentWillMount() {
    this.getMyData();
  }

  getMyData(){
    var self = this;
    this.data.forEach( function(value, index, array) {
        self.handleBook(value)
    });
  }

  handleBook = data => {
    var self = this;
    getISBNApiAsJson(data.isbn)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        var newCatalog = [...self.state.catalog]
        var book = json[Object.keys(json)[0]]
        book["price"] = data.price
        newCatalog.push(book)
        console.log(newCatalog)

        var newCarritoItems = [...self.state.carrito.items]
        newCarritoItems.push(0)
        self.setState({ ...self.state, catalog: newCatalog, carrito: { items: newCarritoItems, cartID: self.state.carrito.cartID }})
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
      }
    }

    if (this.state.path === "/") {
      content = (<StringInputView
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
      console.log(this.state.catalog)
      content = (<CatalogView
        router={router}
        catalog={this.state.catalog}
        carrito={this.state.carrito}
      />)
    } else if (this.state.path === "/cart") {
      content = ( <div>
      <CatalogView
        router={router}
        catalog={this.state.catalog.filter(function (elem, index) {
          return this.state.carrito.items[index] > 0
      }.bind(this))}
        carrito={this.state.carrito}
      />
      <CarritoView  router={router}
      substrings={this.state.catalog.filter(function (elem, index) {
        return this.state.carrito.items[index] > 0
      }.bind(this))} />
      </div>
      )
    } else if (this.state.path === "/book") {
      content = (
      <BookView
        router={router}
        book={this.state.catalog[this.state.bookIndex]}
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
