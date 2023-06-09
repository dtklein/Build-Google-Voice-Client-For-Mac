# Summary: 

This small tool assembles a local client for Google Voice, on OSX. 

# The Rationale

I use Google Voice to maintain a phone number and communicate with others, distinct from the native/local phone number in my cell phone. This number has followed me across providers, locations and situations. 

It's easy to use in Windows and in mobile devices based one IOS and Android, all of which offer a native Google Voice client application. When working in OSX, however, the experience is much poorer. Sure I can run the web-based GUI in a browser, but when I get a message or want to make a call, I have to find which of the dozens of open tabs has Google Voice. This is especially frustrating when it's an incoming phone call, and i have well over a hundred open tabs. 

# How It Works

The tool uses the Node-JS utility [nativefier|https://www.npmjs.com/package/nativefier] to create an [Electron|https://www.electronjs.org] application, wrapping the Google Voice web-based GUI. The tool then uses the [appdmg|https://github.com/LinusU/node-appdmg] Node-JS utility to package the Elctron app as a "dmg" (disk image) file, for easy installation. The tool also uses draw.io to convert a simple XML-described background into a background image, guiding the customer to easily install or upgrade the client. 

# Caveat

I give no gurarantees that it works or is useful for much, other than a toy for me to learn a little.

# Intellectual Property

The Google Voice service and the Google Voice web-based client are both property of Google. I make no claim of ownerhip of those. All my tool does is use existing utilities to package the Google Voice client for a better customer experience, where the interaction feels more akin to a local, native application. 


 - DTK