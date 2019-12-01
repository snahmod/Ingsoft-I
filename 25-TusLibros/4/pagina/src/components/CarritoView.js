// Component
function CarritoView(props) {
  const { router, reducedCatalog } = props
  const classes = useStyles();

  return (
    <div>
      <Button variant="contained" color="primary" className={classes.button}
              disabled = {Object.keys(reducedCatalog).length <= 0}
              onClick = {() => {router.navigate("/checkout", {})} }
              >
        Check out
      </Button>

    </div>
  )
}

