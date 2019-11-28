function QuantityButtons(props) {
  const { bookIndex, router, catalog, carrito } = props
  const classes = useStyles();

  const [itemsCount, setItemsCount] = React.useState(carrito.items);

  const modifyItemCount = (bookIndex, quantity) => {
    const newCount = [...itemsCount];
    newCount[bookIndex].quantity = itemsCount[bookIndex].quantity + quantity;
    setItemsCount(newCount)
    router.setCart({ items: newCount, cartID: carrito.cartID })
  };

  const handleInvalidResponse = () => {
    router.emptyCart()
    router.navigate("/", {})
  };

  const incrementCount = bookIndex => () => {
    addToCart(carrito.cartID, catalog[bookIndex].isbn, (data) => {
      modifyItemCount(bookIndex, 1)
    }, handleInvalidResponse)
  };
  
  const decrementCount = bookIndex => () => {
    removeFromCart(carrito.cartID, catalog[bookIndex].isbn, (data) => {
      modifyItemCount(bookIndex, -1)
    }, handleInvalidResponse)
  };

  return (
    <div>
    <IconButton className={classes.button} aria-label="add" style={{flex: 1}} edge="start" 
    onClick={incrementCount(bookIndex)}>
    <Icon>add</Icon>
    </IconButton>
    <Typography component="h1"style= {{display:'inline-block'}}>{itemsCount[bookIndex].quantity} </Typography>
    <IconButton className={classes.button} aria-label="remove" style={{flex: 1}}
    onClick={decrementCount(bookIndex)} disabled={itemsCount[bookIndex].quantity <= 0}>
    <Icon>remove</Icon>
    </IconButton>
    </div>
  )
}
