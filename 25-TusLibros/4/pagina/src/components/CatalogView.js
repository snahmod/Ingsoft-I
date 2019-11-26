function CatalogView(props) {
  const { router, catalog, carrito } = props
  const classes = useStyles();

  const [itemsCount, setItemsCount] = React.useState(carrito.items);

  const incrementCount = bookIndex => () => {
    const newCount = [...itemsCount];
    newCount[bookIndex] = itemsCount[bookIndex] + 1;
    setItemsCount(newCount)
    router.setCart({ items: newCount, cartID: carrito.cartID })
  };
  
  const decrementCount = bookIndex => () => {
    const newCount = [...itemsCount];
    newCount[bookIndex] = itemsCount[bookIndex] - 1;
    setItemsCount(newCount)
    router.setCart({ items: newCount, cartID: carrito.cartID })
  };

  const navigateTo = bookIndex => () => {
    router.navigate("/book", { bookIndex: bookIndex })
  };
  
  console.log(catalog)
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
            <IconButton className={classes.button} aria-label="add" style={{flex: 1}} edge="start" 
             onClick={incrementCount(bookIndex)}>
            <Icon>add</Icon>
            </IconButton>
            <Typography component="h1"style= {{display:'inline-block'}}>{itemsCount[bookIndex]} </Typography>
            <IconButton className={classes.button} aria-label="remove" style={{flex: 1}}
            onClick={decrementCount(bookIndex)} disabled={itemsCount[bookIndex] <= 0}>
            <Icon>remove</Icon>
            </IconButton>
            </ListItemSecondaryAction>
          </ListItem>
        );
      })}
    </List>
    </div>
  )
}
