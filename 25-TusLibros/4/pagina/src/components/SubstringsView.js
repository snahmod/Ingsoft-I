function CatalogView(props) {
  const { router, catalog, carrito } = props
  const classes = useStyles();

  const [itemsCount, setItemsCount] = React.useState(carrito.items);

  const incrementCount = bookIndex => () => {
    const newCount = [...itemsCount];
    newCount[bookIndex] = itemsCount[bookIndex] + 1;
    setItemsCount(newCount)
    router.setCart({ items: newCount, cartID: carrito.id })
  };
  
  const decrementCount = bookIndex => () => {
    const newCount = [...itemsCount];
    newCount[bookIndex] = itemsCount[bookIndex] - 1;
    setItemsCount(newCount)
    router.setCart({ items: newCount, cartID: carrito.id })
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

function BookView(props) {
  const { router, book } = props
  const classes = useStyles();

  return (
    <div>
       <img src={book.cover.medium} style={{float: 'left', padding: '20px'}}></img>
       <div style={{padding: '35px'}}>
       <Typography component="h1">Title: {book.title} </Typography> <br></br>
       <Typography component="h1">Author: {book.authors[0].name} </Typography> <br></br><br></br>
       <Typography component="h2">Publisher: {book.publishers[0].name} </Typography> <br></br>
       <Typography component="h2">Publish date: {book.publish_date} </Typography> <br></br>
       <Typography component="h2">Number of pages: {book.number_of_pages} </Typography>
       </div>
    </div>
  )
}
