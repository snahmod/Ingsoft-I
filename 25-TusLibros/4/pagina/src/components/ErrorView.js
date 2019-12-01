function ErrorView(props) {
  const { router, error, carrito} = props
  const classes = useStyles();

  const navigateTo = () => () => {
    carrito.emptyCart()
    router.navigate("/", {})
  };

  return (
    <div>
      <h1>Oops. Hubo un error: {error}</h1>
      <Button variant="contained" color="primary" className={classes.button}
              onClick = {navigateTo()}
              >
        Log Out
      </Button>
    </div>
  );
}