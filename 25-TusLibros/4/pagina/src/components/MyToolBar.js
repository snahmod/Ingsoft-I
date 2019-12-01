    function MyToolBar(props) {
      const classes = useStyles();
      const {title, router, carrito} = props;
    
      let menuButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=> {
            carrito.emptyCart()
            router.navigate("/", {})
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
          onClick={()=>router.navigate("/cart", {})}
          >
          <Icon>shopping_cart</Icon>
        </IconButton>
      )

      let catalogButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate("/catalog", {})}
          >
          <Icon>list</Icon>
        </IconButton>
      )

      let purchasesButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate("/listPurchases", {})}
          >
          <Icon>account_circle</Icon>
        </IconButton>
      )

      if (router.current() === "/" || router.current() === "/error") {

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
              {/*<Button color="inherit">Login</Button>*/}
            </Toolbar>
          </AppBar>
        </div>
      )
    }
