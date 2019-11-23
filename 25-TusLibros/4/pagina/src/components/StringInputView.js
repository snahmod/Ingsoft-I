
function StringInputView(props) {
  const { router } = props
  const classes = useStyles();
  const [values, setValues] = React.useState({
    text: '',
  });
  const handleChange = prop => event => {
    setValues({ ...values, [prop]: event.target.value });
  };
  const handleSend = text => {
    loading = true;
    getLocalAsJson(`substrings?sentence=${text}`)
      .then(function (response) {
        loading = false;
        return response.json()
      })
      .then(function (json) {
        loading = false;
        router.navigate("/catalog", { substrings: json })
      })
      .catch(function (error) {
        loading = false;
        console.log('Looks like there was a problem: \n', error);
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
              value={values.text}
              onChange={handleChange('text')}
              className={classes.textField}
              label="User"
              autoComplete="off"
            />
            </div>
            <div>
            
          <TextField 
            id="standard-password-input"
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
            onClick={() => handleSend(values.text)}>
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
