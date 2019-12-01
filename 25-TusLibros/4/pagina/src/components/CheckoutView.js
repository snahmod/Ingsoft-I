function CheckoutView(props) {
  const { router, catalog, carrito, userCredentials } = props
  const classes = useStyles();
  const [purchase, setPurchase] = React.useState({ items: [], total_amount: 0 });

  React.useEffect(() => {
    checkoutCart(carrito.cartID, (data) => {
      setPurchase(data)
      login(userCredentials.userID, userCredentials.password, json => {
        console.log('carrito')
        console.log(carrito)
        carrito.emptyCart()
        carrito.setCartID(json.cartID)
        console.log('carrito')
        console.log(carrito)
        
      }, data => {})
    }, (data) => {
      router.navigate('/error', { error: data.message })
    })
  }, [])

  return (
    <div>
    <List dense className={classes.list}>
      {purchase.items.map(item => {
        return (
        <BookListItemView
          key={item.isbn}
          router={router}
          catalog={catalog}
          bookIsbn={item.isbn}
          bookListItemQuantityView={
          <Typography component="h1"style= {{display:'inline-block'}}>{item.quantity} </Typography>}
        />
        );
      })}
    </List>
    <Typography component="h2"><b>Total Amount:</b> {"$" + purchase.total_amount} </Typography>
    </div>
  )
}
