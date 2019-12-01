function CatalogView(props) {
  const { router, catalog, carrito } = props
  const classes = useStyles();

  console.log('Cart ID:', carrito.cartID)
  console.log('Catalgo:', catalog)

  return (
    <div>
    <List dense className={classes.list}>
      {Object.keys(catalog).map(bookIsbn => {
        return (
        <BookListItemView
          key={bookIsbn}
          router={router}
          catalog={catalog}
          bookIsbn={bookIsbn}
          bookListItemQuantityView={
          <QuantityButtonsView
            bookIsbn={bookIsbn}
            router={router}
            catalog={catalog}
            carrito={carrito}
          />}
        />
        );
      })}
    </List>
    </div>
  )
}
