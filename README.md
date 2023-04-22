# CHATGPT SPEECH INTERFACE

A Simple App that interfaces chat-gpt interface
The app is composed of:

**Server**: A simple dart server that serves the voice web page, and the routes to perform a socket comunication.
**App**: A Flutter web app which is used to interact with the chat.
**Ai_Code**: A Javascript file with the code to inject in chat-gpt page to get the chat input/output.

# ABOUT COPYRIGHT
This app doesn't intend to be a hack or something like this. It's not intend to be used for comercial purpose.
All it does is to give you the capability of interact with the oficial chatgpt beyond text. If you don't have
rights to use chat-gpt it will not work for you.


# HOW IT WORKS

1. Open chat-gpt in a browser tab.
2. Open javascript console in dev-tools
3. Copy and paste ai_code.js in console
4. Open the chat_server.exe (it will open the server in 8080 port)
5. Open localhost:8080/ in another browser tab

That's it. Now you can interact with the chat through voice chat.

# LIMITATIONS
Due to the time spended to chat form the answer, the interface will wait until it finishes. That's why, depend on the answer length, takes time to get a response through the interface.
One way to decrease the time, is to implement a stream based on the chunks of the chat response. Feel free to make improviments.


# CONTRIBUTE
This is not intend to be a serious project in anyway.
But if you would like to improve this in some way, feel free to send me a pull request or open an issue.

