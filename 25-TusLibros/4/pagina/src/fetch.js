const getLocalAsJson = (path) => {
  var port = 8082

  return fetch(`http://localhost:${port}/${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
}

const getISBNApiAsJson = (isbn) => {
  return fetch(`https://openlibrary.org/api/books?bibkeys=ISBN:${isbn}&format=json&jscmd=data`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
}

const modifyCart = (action, cartID, isbn, handleResponse) => {
  getLocalAsJson(`${action}?quantity=1&isbn=${isbn}&cartID=${cartID}`)
    .then(function (response) {
      return response.json()
    })
    .then(handleResponse)
    .catch(function (error) {
      console.log('Looks like there was a problem: \n', error);
    });
}

const addToCart = (cartID, isbn, handleResponse) => {
  modifyCart('addToCart', cartID, isbn, handleResponse)
}

const removeFromCart = (cartID, isbn, handleResponse) => {
  modifyCart('removeFromCart', cartID, isbn, handleResponse)
}
