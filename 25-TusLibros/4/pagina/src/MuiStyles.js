const theme = createMuiTheme({
  palette: {
    primary: {
      main: '#556cd6',
    },
    secondary: {
      main: '#19857b',
    },
    error: {
      main: colors.red.A400,
    },
    background: {
      default: '#fff',
      paper: '#f5f5f5',
    },
  },
});
const useStyles = makeStyles(theme => ({
  list: {
    margin: theme.spacing(0, 0, 0, 0),
  },
  login: {
    height: "60vh",
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  },
  root: {
    margin: theme.spacing(6, 0, 3),
  },
  lightBulb: {
    verticalAlign: 'middle',
    // marginRight: theme.spacing(1),
  },
  rootToolBar: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  textField: {
        marginTop: theme.spacing(1),
        marginBottom: theme.spacing(1),
        width: '100%',
        textAlign: 'center',
  },
  title: {
    flexGrow: 1,
  },
  rootList: {
    width: '100%',
    backgroundColor: theme.palette.background.paper,
    position: 'relative',
    overflow: 'auto',
    maxHeight: 300,
  },
  textFieldDetails: {
    margin: theme.spacing(2),
  }
}));
