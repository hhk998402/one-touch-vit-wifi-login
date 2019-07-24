import requests

# logoutURL = 'http://phc.prontonetworks.com/cgi-bin/authlogout'
# requests.post(url = logoutURL)

URL = 'http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftconnecttest.com/redirect'
PARAMS = {
	'userId': '16BCE2004',
	'password': 'KannanAmbady998',
	'serviceName': 'ProntoAuthentication'
}
print(PARAMS)

r = requests.post(url = URL, data = PARAMS)
print(r.text)

