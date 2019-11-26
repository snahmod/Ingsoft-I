
function StringInputView(props) {
  const { router } = props
  const classes = useStyles();
  const [userCredentials, setUserCredentials] = React.useState({
    userID: '',
    password: ''
  });

  const handleChange = prop => event => {
    setUserCredentials({ ...userCredentials, [prop]: event.target.value });
  };

  const handleSend = (userID, password) => {
    loading = true;
    getLocalAsJson(`createCart?userID=${userID}&password=${password}`)
      .then(function (response) {
        loading = false;
        console.log(response)
        if (response.status == 200) return response.json()
        alert('holaala')
      })
      .then(function (json) {
        loading = false;
        router.navigate("/catalog", { substrings: json })
      })
      .catch(function (error) {
        loading = false;
        console.log('Looks like there was a problem: \n', error);
        alert('hola');
      });
  }
  var loading = false;

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
            onClick={() => handleSend(userCredentials.userID, userCredentials.password)}>
            Ingresar
              </Button>
          </div>
          <div> </div>
          {loading ? <div style={{display: 'flex', justifyContent: 'center'}}>
          <CircularProgress />
</div> : <div> </div> }
          </FormControl>



    
    </div>
  )
}
