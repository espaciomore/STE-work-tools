# CommunicationePro QA Bash Collections
This is a collections of bash scripts I have created for automating some of my work for quality assurance.

## Usage

### 2Notify
Sends an MO message using the /2notify/2NotifyResponse API
`./2Notify.sh [US|UK.QA|PROD] [0-9] [username:password] [inbound_address] [message] [filename] [carrier]`

### BuildHistory
Retrieves the latest builds from Jenkins
`./BuildHistory.sh [dev-master|master] [0-9]` 

### Chat
Retrieves the Chat Sessions using the /chat/refresh service
`./Chat.sh [US|UK.QA|PROD] [0-9] [resolution]`

### CloseChat
Closes Chat Sessions
`./CloseChat.sh [US|UK.QA|PROD] [0-9] [filename] [RESOLVED|ESC_PHONE|ESC_EMAIL|UNABLE] [comment]`

### Connect
Sends an MO message using the /api/connect/molistener API
`./Connect.sh [US|UK.QA|PROD] [0-9] [username:password] [inbound_address] [message] [filename]`

### CouponGenerator
Generates a CSV file containing N coupons with the specified format
`./CouponGenerator.sh [alpha-code] [numeric-code] [size]`

### Deploy
Opens an SSH connection to the specified server in *sudo* level
`./Deploy.sh [US|UK.QA|PROD] [0-9] [username]`

### Login
Logins to CommPro to generate a cookie file to keep a session active
`./Login.sh [US|UK.QA|PROD] [0-9] [username:password]`

### MDN_Generator
Generates a CSV file containing N phone numbers with the specified format
`./MDN_Generator.sh [ US{1 XXX XXX XXXX} | UK{44 XXX XXXX XXXX} ] [size]`

### MultiFunction
Sends an MO message using the /api/multiFunction API
`./MultiFunction.sh [US|UK.QA|PROD] [0-9] [username:password] [filename] [message] [programID]`

### OptIn
Adds subscriber to a list using /api/optIn API
`./OptIn.sh [US|UK.QA|PROD] [0-9] [username:password] [list_id] [filename]`

### QueueControl
Retrieves a Broadcast delivery status
`./QueueControl.sh [US|UK.QA|PROD] [0-9] [broadcast_id]`

### SanityTest
Executes an automated sanity test
`./SanityTest.sh [US|UK.QA|PROD] [0-9] [username:password] [broadcast_id]`

### SaveProperty
Updates subscriber's properties using /api/saveProperties API
`./SaveProperty.sh [US|UK.QA|PROD] [0-9] [username:password] [filename] [name] [value]`

### SendBroadcast
Sends a Broadcast Message using the /consoleapp/doSendBroadcastMessage.jspx service
`./SendBroadcast.sh [US|UK.QA|PROD] [0-9] [broadcast_id]`

### SmokeTest
Executes an automated smoke test
`./SmokeTest.sh [US|UK.QA|PROD] [0-9]`

### SymbolToURL
Translates pseudoname to URL
`./SymbolToURL.sh [US|UK.QA|PROD] [0-9]`

### ViewVersion
Retrieves the build version for the specified server(s)
`./ViewVersion.sh [US|UK.QA|PROD] [0-9]`

### WebMO
Sends an MO message using the /api/externalMO API
`./WebMO.sh [US|UK.QA|PROD] [0-9] [username:password] [shortcode] [message] [filename] [campaignID] [carrier]`
