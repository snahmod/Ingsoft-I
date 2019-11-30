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

const listPurchases = (userID, password, handleResponse) => {
  getLocalAsJson(`listPurchases?userID=${userID}&password=${password}`)
    .then(function (response) {
      return response.json()
    })
    .then(handleResponse)
    .catch(function (error) {
      console.log('Looks like there was a problem: \n', error);
    });
}

const modifyCart = (action, cartID, isbn, handleResponse, onFailureDo) => {
  getLocalAsJson(`${action}?quantity=1&isbn=${isbn}&cartID=${cartID}`)
    .then(function (response) {
      return response.json()
    })
    .then(handleResponse)
    .catch(function (error) {
      console.log('Looks like there was a problem: \n', error);
      onFailureDo()
    });
}

const addToCart = (cartID, isbn, handleResponse, onFailureDo) => {
  modifyCart('addToCart', cartID, isbn, handleResponse, onFailureDo)
}

const removeFromCart = (cartID, isbn, handleResponse, onFailureDo) => {
  modifyCart('removeFromCart', cartID, isbn, handleResponse, onFailureDo)
}
