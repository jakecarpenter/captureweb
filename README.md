Capture overview:

Clients
Mobile
	Android & iOS; Flat UI, native uploader
Web
	FlatUI, includes advanced sorting and curating features. 

Data Information
General:
Functions and Variables are CamelCase, urls & end-points are hyphenated.

1. Models:
User: 
id
email
fullName
firstName
middleName
lastName
userName

Card:
id
service (where its from, twitter, fb, instagram, etc)
serviceTime (when the service reports it as occurring)
createdAt (when it enters our system
contributor (id of user)
visibility (public, private, invisible (only visible to Capture staff), redacted)

Capture (formerly Event, but called slice to avoid confusion with native Events on various platforms. Each Capture represents a Duration and a Place)
id
location (an array of geopoints describing a location?)
startTime
endTime
creator
description
title
visibility

Comment
id
target (what is this a comment on?)
text
contributor (id of commenter)
createdAt
editedAt
Decks
id
name
desc
creator
Decks
deckId
cardId
order (where in the deck this sits)
twitterAuth
userId
tokens(x4)
facebookAuth
userId
tokens(x2)
instagramAuth
userId
googeAuth
userId


Access API

general: everything is https, with the following headers: X-Capture-token, X-Capture-session, X-Capture-client-id

all URLs follow the following layout:
http://{domain}/api/users

users:
	/users
	list all users

	/user/{id}
	return account information for {id}

	/user/{id}/link
	post to this fb/twitter/instagram, etc info for account linking

cards:
	/card/{id}
	return a card

	/cards/{id}/comments
	returns comments for a card

	/card
	POST a card to this to add a card
	  will return an id if posted to a valid event
	  if not posted to an event, it will return an object containing possible events to post to, and schedule a notificaiton to the client 

capture:
	/captures
	returns captures, can filter by (location, time, etc)

	/capture/{id}
	return all of a capture’s info

/capture/{id}/comments
	return all of a capture’s comments

	/capture/{id}/cards
	show all the public cards for a capture

	/capture/{id}/users
	show the users currently invited/attending an event

	/capture/query
	


decks
	/decks
	returns decks, can filter by (location, time, etc)

	/deck/{id}
	return all of a decks info

	/deck/{id}/cards
	show all the public cards for a deck

comments
	/comment/{id}
	return a comment

	/comment
	POST to comment to add a comment. 

login
	/login
	POST an object with a username or email or id and a sha1 password hash.
	POST login tokens from a federated provider 
	returns session info

	/logout
	end the current session

	/login/status
	returns current status of login
