const functions = require('firebase-functions');
const stripe = require('stripe')('sk_test_51HSkkpGqiuzQS1fhEtX8bsYNlX0UrTfMQZo4ZD7gu9L20BIKZMwwLqg5zfhQrLhZ8f1kCxZvhhIjS8Itk0ycrWBS00LPzSpdFv');


exports.getCustomerPaymentMethods = functions.https.onRequest(async(req,res)=>{
    try{
        let customerId;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });

    
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        }
        else {
         res.status(404).send({
            'status':'failed',
            "message":'user not found',
         })
        }

        const paymentMethods = await stripe.paymentMethods.list({
            customer: cus,
            type: 'card',
          });
        res.status(200).send({
            'status':'success',
            paymentMethods,
        })
    }catch(error){
        res.send(404).send({
            'status':'failed',
            "message":error.message,
        })
    }
})