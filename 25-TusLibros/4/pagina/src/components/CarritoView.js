// Component
function CarritoView(props) {
  const { router, reducedCatalog } = props
  const classes = useStyles();

  return (
    <div>
      <Button variant="contained" color="primary" className={classes.button} disabled = {reducedCatalog.length <= 0}>
        Check out
      </Button>

    </div>
  )
}

