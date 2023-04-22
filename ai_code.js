class Messenger {
    constructor() {
        this.listenServer();
    }

    listenServer() {
        fetch('http://localhost:8080/clientMessage', { method: 'GET' })
            .then((response) => {
                return response.json();
            })
            .then((response) => {
                if (response != undefined && response["message"] != '') {
                    this.sendMessage(response['message'])
                } else {
                    setTimeout(() => {
                        this.listenServer();
                    }, 1000);
                }
            });
    }


    responds(message) {
        fetch('http://localhost:8080/iaResponse', { method: 'POST', body: JSON.stringify({ message: message }) })
            .then((response) => response.json())
            .then(() => {
                this.listenServer();
            })
    }



    sendMessage(message) {
        var messageElement = document.querySelector('*[placeholder="Send a message..."]');
        messageElement.textContent = message;
        messageElement.value = message;

        var button = messageElement.nextElementSibling;
        button.disabled = false;
        button.click();

        var response;

        var interval = setInterval(() => {
            var res = document.querySelector('main').firstChild.firstChild.firstChild.firstChild.lastChild.previousElementSibling.innerText;
            if (res == response) {
                clearInterval(interval);
                this.responds(response);
            } else {
                response = res;
            }
        }, 1000);
    }

}

new Messenger();