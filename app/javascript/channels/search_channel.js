App.searches = App.cable.subscriptions.create("SearchChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const search = document.querySelector("#searches")
    search.innerHTML = data.html
  }
});
