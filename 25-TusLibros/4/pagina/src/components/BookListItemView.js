function BookListItemView(props) {
  const { router, catalog, bookIsbn, bookListItemQuantityView } = props
  const classes = useStyles()

  const navigateTo = bookIsbn => () => {
    router.navigate("/book", { bookIsbn: bookIsbn })
  }

  const labelId = `checkbox-list-secondary-label-${bookIsbn}`
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
        {bookListItemQuantityView}
      </ListItemSecondaryAction>
    </ListItem>
  );
}