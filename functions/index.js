const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
admin.initializeApp();
let transporter = nodemailer.createTransport({
    service: 'gmail',
        auth: {
                user: 'tempbhav123@gmail.com',
                pass: 'Bhavik@123'  //you your password
            }
});
exports.sendMail = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
         // getting dest email by query string
        const dest = req.query.dest;
        min =   Math.ceil(1000);
        max = Math.floor(9999);
        const ramd = Math.floor(Math.random()*(max-min)+min);
        const mailOptions = {
            from: 'Agile Developers <agile.developers1804@gmail.com>', // 
            to: dest,
            subject: 'Welcome to ABC', // email subject
            html: `Dear User, Welcome to ABC, <p>thank you for choosing us${ramd}      `
        };
        // returning result
        return transporter.sendMail(mailOptions, (erro, info) => {
            if(erro){
                return res.send(erro.toString());
            }
            return res.send(ramd.toString());
        });
    });
});