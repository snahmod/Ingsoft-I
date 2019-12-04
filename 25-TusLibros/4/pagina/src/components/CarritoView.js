// Component
function CarritoView(props) {
  const { router, reducedCatalog, carrito } = props
  const classes = useStyles()

  return (
    <div>
      <CatalogView router={router} catalog={reducedCatalog} carrito={carrito}/>
      <Button variant="contained" color="primary" className={classes.button}
              disabled = {Object.keys(reducedCatalog).length <= 0}
              onClick = {() => {router.navigate(ROUTE_CHECKOUT, {})} }
              >
        Check out
      </Button>

    </div>
  )
}

