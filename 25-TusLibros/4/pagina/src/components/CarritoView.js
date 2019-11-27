// Fetch Hook
const useFetchDetails = (substring) => {
  const [details, setDetails] = React.useState([])
  const [loading, setLoading] = React.useState(false)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    setLoading(true)
    setError(null)

    let details = {}

    getLocalAsJson(`sayhi`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["firstLetter"] = json

        setLoading(false)
        if (details) {
          setDetails(details)
        } else {
          setDetails([])
        }
      })
      .then(function () {
        setLoading(true)
        setError(null)

        return getLocalAsJson(`touppercase?word=${substring}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["uppercase"] = json

        setLoading(false)
        if (details) {
          setDetails(details)
        } else {
          setDetails([])
        }
      })
      .then(function () {
        setLoading(true)
        setError(null)

        return getLocalAsJson(`vowels?word=${substring}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["vowels"] = json

        setLoading(false)
        if (details) {
          setDetails(details)
        } else {
          setDetails([])
        }
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [substring])

  return { details, loading, error }
}

// Component
function CarritoView(props) {
  const { router, reducedCatalog } = props
  const classes = useStyles();
  
  //const { details, loading, error } = useFetchDetails(selectedSubstring)

  // if (loading) return <div>Loading...</div>
  // if (error) return <div>{error}</div>

  return (
    <div>
      <Button variant="contained" color="primary" className={classes.button} disabled = {reducedCatalog.length <= 0}>
        Check out
      </Button>

    </div>
  )
}

