function QuantityButtonsView(props) {
  const { bookIsbn, router, catalog, carrito } = props
  const classes = useStyles();

  const [itemsCount, setItemsCount] = React.useState(carrito.items);

  const modifyItemCount = (bookIsbn, quantity) => {
    const newCount = {...itemsCount};
    newCount[bookIsbn].quantity = itemsCount[bookIsbn].quantity + quantity;
    setItemsCount(newCount)
    carrito.setCartItems(newCount)
  };

  const handleInvalidResponse = (data) => {
    router.navigate('/error', { error: data.message })
  };

  const incrementCount = bookIsbn => () => {
    addToCart(carrito.cartID, bookIsbn, (data) => {
      modifyItemCount(bookIsbn, 1)
    }, handleInvalidResponse)
  };
  
  const decrementCount = bookIsbn => () => {
    removeFromCart(carrito.cartID, bookIsbn, (data) => {
      modifyItemCount(bookIsbn, -1)
    }, handleInvalidResponse)
  };

  return (
    <div>
      <IconButton className={classes.button} aria-label="add" style={{flex: 1}} edge="start" 
      onClick={incrementCount(bookIsbn)}>
        < Icon>add</Icon>
      </IconButton>

      <Typography component="h1"style= {{display:'inline-block'}}>
        {itemsCount[bookIsbn].quantity}
      </Typography>

      <IconButton className={classes.button} aria-label="remove" style={{flex: 1}}
      onClick={decrementCount(bookIsbn)} disabled={itemsCount[bookIsbn].quantity <= 0}>
        <Icon>remove</Icon>
      </IconButton>
    </div>
  )
}
