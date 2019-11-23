function CatalogView(props) {
  const { router, substrings, carrito } = props
  const classes = useStyles();

  const [count, setCount] = React.useState(carrito);

  const incrementCount = value => () => {
    const newCount = [...count];
    newCount[value] = count[value] + 1;
    setCount(newCount)
    router.setCart(newCount)
  };
  
  const decrementCount = value => () => {
    const newCount = [...count];
    newCount[value] = count[value] - 1;
    setCount(newCount)
    router.setCart(newCount)
  };

  const navigateTo = value => () => {
    router.navigate("/book", { bookIndex: value })
  };
  

  return (
    <div>
    <List dense className={classes.list}>
      {[...Array(substrings.length).keys()].map(value => {
        const labelId = `checkbox-list-secondary-label-${value}`;
        return (
          <ListItem key={value} button onClick={navigateTo(value)}>
            <ListItemAvatar>
              <Avatar
                variant="rounded" className={classes.rounded}
                src={substrings[value].cover.small}
              />
            </ListItemAvatar>
            <ListItemText id={labelId} primary={substrings[value].title} secondary={substrings[value].price} />
            <ListItemSecondaryAction>
            <IconButton className={classes.button} aria-label="add" style={{flex: 1}} edge="start" 
             onClick={incrementCount(value)}>
            <Icon>add</Icon>
            </IconButton>
            <Typography component="h1"style= {{display:'inline-block'}}>{count[value]} </Typography>
            <IconButton className={classes.button} aria-label="remove" style={{flex: 1}}
            onClick={decrementCount(value)} disabled={count[value] <= 0}>
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
