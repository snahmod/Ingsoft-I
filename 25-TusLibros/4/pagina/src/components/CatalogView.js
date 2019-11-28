function CatalogView(props) {
  const { router, catalog, carrito } = props
  const classes = useStyles();

  console.log('Cart ID:', carrito.cartID)

  const navigateTo = bookIndex => () => {
    router.navigate("/book", { bookIndex: bookIndex })
  };

  return (
    <div>
    <List dense className={classes.list}>
      {[...Array(catalog.length).keys()].map(bookIndex => {
        const labelId = `checkbox-list-secondary-label-${bookIndex}`;
        return (
          <ListItem key={bookIndex} button onClick={navigateTo(bookIndex)}>
            <ListItemAvatar>
              <Avatar
                variant="rounded" className={classes.rounded}
                src={catalog[bookIndex].cover.small}
              />
            </ListItemAvatar>
            <ListItemText id={labelId} primary={catalog[bookIndex].title} secondary={catalog[bookIndex].price} />
            <ListItemSecondaryAction>
              <QuantityButtons
                bookIndex={bookIndex}
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
