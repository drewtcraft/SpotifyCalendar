//import dependencies
const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser')
const app = express();
const port = process.env.PORT || 5000;
const calendarRouter = require('./routes/calendarRoutes.js')

//set up for logging
app.use(logger('dev'));

//set up body parser for posting & putting
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

//general message
app.get('/', (req,res)=>res.send('testing 123'))

//set up calendar router
app.use('/calendar', calendarRouter)

//catch all errors
// app.use((err, req, res, next) => {
//   res.status(500).send('Something has gone terribly wrong. This machine is revolting!')
// })

//tell the server where to listen
app.listen(port, () => console.log(`Listening on port ${port}`));
