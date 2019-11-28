    function MyToolBar(props) {
      const classes = useStyles();
      const {title, router} = props;
    
      let menuButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=> {
            router.emptyCart()
            router.navigate("/", {
            substrings: [],
            selectedSubstring: "",})
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
          onClick={()=>router.navigate("/cart", {
            substrings: [],
            selectedSubstring: "",})}
          >
          <Icon>shopping_cart</Icon>
        </IconButton>
      )

      let catalogButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate("/catalog", {
            substrings: [],
            selectedSubstring: "",})}
          >
          <Icon>list</Icon>
        </IconButton>
      )

      let purchasesButton = (
        <IconButton
          edge="start"
          className={classes.menuButton}
          color="inherit"
          onClick={()=>router.navigate("/", {
            substrings: [],
            selectedSubstring: "",})}
          >
          <Icon>account_circle</Icon>
        </IconButton>
      )

      if (router.current() === "/") {

        menuButton = (<div></div>)
        carritoButton = (<div></div>)
        purchasesButton = (<div></div>)
        catalogButton = (<div></div>)
      }
    
      // if (router.current() === "/cart") {
      //   menuButton = (
      //     <IconButton
      //       edge="start"
      //       className={classes.menuButton}
      //       color="inherit"
      //       onClick={()=>router.navigate("/catalog", {
      //       selectedSubstring: "",})}
      //     >
      //       <Icon>keyboard_arrow_left</Icon>
      //     </IconButton>
      //   )
      // }
    
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
