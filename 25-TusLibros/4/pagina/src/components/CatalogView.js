function CatalogView(props) {
  const { router, catalog, carrito } = props
  const classes = useStyles();

  console.log('Cart ID:', carrito.cartID)

  const navigateTo = bookIsbn => () => {
    router.navigate("/book", { bookIsbn: bookIsbn })
  };

  console.log('Catalgo:', catalog)

  return (
    <div>
    <List dense className={classes.list}>
      {Object.keys(catalog).map(bookIsbn => {
        const labelId = `checkbox-list-secondary-label-${bookIsbn}`;
        return (
          <ListItem key={bookIsbn} button onClick={navigateTo(bookIsbn)}>
            <ListItemAvatar>
              <Avatar
                variant="rounded" className={classes.rounded}
                src={catalog[bookIsbn].cover.small}
              />
            </ListItemAvatar>
            <ListItemText id={labelId} primary={catalog[bookIsbn].title} secondary={catalog[bookIsbn].price} />
            <ListItemSecondaryAction>
              <QuantityButtons
                bookIsbn={bookIsbn}
                router={router}
                catalog={catalog}
                carrito={carrito}
              />
            </ListItemSecondaryAction>
          </ListItem>
        );
      })}
    </List>
    </div>
  )
}
