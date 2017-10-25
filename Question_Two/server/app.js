const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();



app.set('trust proxy', 1);


const loginRequest = (username, password) =>
  new Promise((res, rej) => {
    const options = {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      url:
        'https://auth.healthforge.io/auth/realms/interview/protocol/openid-connect/token',
      form: {
        username,
        password,
        grant_type: 'password',
        client_id: 'interview'
      },
      method: 'POST'
    };

    request(options, (err, response, body) => {
      // Reject general errors in request
      if (err) {
        rej('Sorry, try again');
      } else {

        body = JSON.parse(body);
        if (body.error) {
          rej('Sorry your username or password are not correct');
        } else {
          res(body.access_token);
        }
      }
    });
  });



// app.get('/*', (__, res) => {
//   const staticPath = 'public';
//   res.sendFile(path.join(staticPath, 'index.html'));
// });

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  loginRequest(username, password)
    .then(token => {
      res.status(200).json({
        token
      });
    })
    .catch(error => {
      res.status(500).json({
        error
      });
    });
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '..', 'public')));

module.exports = app;
