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

const getApiCall = (path, handleResponse, onFailureDo) => {
  getLocalAsJson(path)
    .then(function (response) {
      console.log(response)
      if (response.ok) return response.json()

      response.json().then(data => { onFailureDo(data) });
      throw new Error
    })
    .then(function (json) {
      handleResponse(json)
    })
    .catch(function (error) {
      console.log('Looks like there was a problem: \n', error);
    });
}

const login = (userID, password, handleResponse, onFailureDo) => {
  getApiCall(`createCart?userID=${userID}&password=${password}`, handleResponse, onFailureDo)
}

const checkoutCart = (cartID, handleResponse, onFailureDo) => {
  getApiCall(`checkoutCart?cartID=${cartID}`, handleResponse, onFailureDo)
}

const listPurchases = (userID, password, handleResponse, onFailureDo) => {
  getApiCall(`listPurchases?userID=${userID}&password=${password}`, handleResponse, onFailureDo)
}

const modifyCart = (action, cartID, isbn, handleResponse, onFailureDo) => {
  getApiCall(`${action}?quantity=1&isbn=${isbn}&cartID=${cartID}`, handleResponse, onFailureDo)
}

const addToCart = (cartID, isbn, handleResponse, onFailureDo) => {
  modifyCart('addToCart', cartID, isbn, handleResponse, onFailureDo)
}

const removeFromCart = (cartID, isbn, handleResponse, onFailureDo) => {
  modifyCart('removeFromCart', cartID, isbn, handleResponse, onFailureDo)
}
