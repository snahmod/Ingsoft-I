function BookView(props) {
  const { router, bookIsbn, catalog, carrito } = props

  const book = catalog[bookIsbn]

  return (
    <div>
       <img src={book.cover.medium} style={{float: 'left', padding: '20px'}}></img>
       <div style={{padding: '35px'}}>
       <Typography component="h1"><b>Title:</b> {book.title} </Typography> <br></br>
       <Typography component="h1"><b>Author:</b> {book.authors[0].name} </Typography> <br></br><br></br>
       <Typography component="h2"><b>Publisher:</b> {book.publishers[0].name} </Typography> <br></br>
       <Typography component="h2"><b>Publish date:</b> {book.publish_date} </Typography> <br></br>
       <Typography component="h2"><b>Number of pages:</b> {book.number_of_pages} </Typography> <br></br>
       <Typography component="h2"><b>Price:</b> {book.price} </Typography>

       <QuantityButtonsView
          bookIsbn={bookIsbn}
          router={router}
          catalog={catalog}
          carrito={carrito}
        />
       </div>
    </div>
  )
}
