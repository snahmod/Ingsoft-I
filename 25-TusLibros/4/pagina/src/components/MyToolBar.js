    function MyToolBar(props) {
      const classes = useStyles()
      const {title, router, carrito} = props
    
      let menuButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=> {
            carrito.emptyCart()
            router.navigate(ROUTE_HOME, {})
            }
          }
          >
          <Icon>close</Icon>
        </IconButton>
      )

      let carritoButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate(ROUTE_CART, {})}
          >
          <Icon>shopping_cart</Icon>
        </IconButton>
      )

      let catalogButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate(ROUTE_CATALOG, {})}
          >
          <Icon>list</Icon>
        </IconButton>
      )

      let purchasesButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate(ROUTE_LISTPURCHASES, {})}
          >
          <Icon>account_circle</Icon>
        </IconButton>
      )

      if (router.current() === ROUTE_HOME || router.current() === ROUTE_ERROR) {

        menuButton = (<div></div>)
        carritoButton = (<div></div>)
        purchasesButton = (<div></div>)
        catalogButton = (<div></div>)
      }
    
      return (
        <div className={classes.rootToolBar}>
          <AppBar position="static">
            <Toolbar>
              {menuButton}
              {catalogButton}
              {carritoButton}
              {purchasesButton}
              <Typography variant="h6" className={classes.title}>
                {title}
              </Typography>
            </Toolbar>
          </AppBar>
        </div>
      )
    }
