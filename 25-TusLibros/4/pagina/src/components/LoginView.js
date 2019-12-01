
function LoginView(props) {
  const { router, carrito } = props
  const classes = useStyles();
  const [userCredentials, setUserCredentials] = React.useState({
    userID: '',
    password: ''
  });

  const [dialog, setDialog] = React.useState({ open: false, message: '' });

  const closeDialog = () => {
    setDialog({ open: false, message: '' });
  };

  const handleChange = prop => event => {
    setUserCredentials({ ...userCredentials, [prop]: event.target.value });
  };

  const userLogin = (userID, password) => {
    login(userID, password, json => {
      console.log('hola')
      router.setUserCredentials(userID, password)
      router.navigate("/catalog", { carrito: { ...carrito, cartID: json.cartID } })
    }, data => {
      setDialog({ open: true, message: data.message })
    })
  }

  return (
    <div>
          <FormControl fullWidth className={classes.login} variant="outlined">
                    <Typography component="h1" gutterBottom style={{textAlignVertical: "center",textAlign: "center",}}>
            Ingrese su usuario y contraseña
              </Typography>
            <div>
            <TextField 
              id="outlined-adornment-amount"
              value={userCredentials.userID}
              onChange={handleChange('userID')}
              className={classes.textField}
              label="User"
              autoComplete="off"
            />
            </div>
            <div>
            
          <TextField 
            id="standard-password-input"
            value={userCredentials.password}
            onChange={handleChange('password')}
            label="Password"
            className={classes.textField}
            type="password"
            autoComplete="current-password"
            />
          </div>

                      <div>
    
          <Button 
          color="primary" 
             className={classes.button}
            onClick={() => userLogin(userCredentials.userID, userCredentials.password)}>
            Ingresar
              </Button>
          </div>
          <div> </div>
          </FormControl>


          <Dialog
            open={dialog.open}
            keepMounted
            style={{backgroundColor: 'red'}}
            onClose={closeDialog}
            aria-labelledby="alert-dialog-slide-title"
            aria-describedby="alert-dialog-slide-description"
          >
            <DialogTitle id="alert-dialog-slide-title">{"Login Failed"}</DialogTitle>
            <DialogContent>
              <DialogContentText id="alert-dialog-slide-description">
                {dialog.message}
              </DialogContentText>
            </DialogContent>
            <DialogActions>
              <Button onClick={closeDialog} color="primary">
                Ok
              </Button>
            </DialogActions>
          </Dialog>
    
    </div>
  )
}
