function PurchasesView(props) {
  const { router, catalog, userCredentials } = props
  const [purchases, setPurchases] = React.useState({ items: [], total_amount: 0 });
  const classes = useStyles();

  React.useEffect(() => {
    listPurchases(userCredentials.userID, userCredentials.password, (data) => {
      setPurchases(data)
      console.log('Purchases:', data)
    }, (data) => {
      router.navigate('/error', { error: data.message })
    })
  }, [])

  return (
    <div>
    <List dense className={classes.list}>
      {purchases.items.map(item => {
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
    <Typography component="h2"><b>Total Amount:</b> {"$" + purchases.total_amount} </Typography>
    </div>
  )
}
