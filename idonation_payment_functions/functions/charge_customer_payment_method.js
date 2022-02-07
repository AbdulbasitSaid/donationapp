const functions = require('firebase-functions');
const stripe = require('stripe')('sk_test_51HSkkpGqiuzQS1fhEtX8bsYNlX0UrTfMQZo4ZD7gu9L20BIKZMwwLqg5zfhQrLhZ8f1kCxZvhhIjS8Itk0ycrWBS00LPzSpdFv');

exports.chargeCustomerPaymentMethod = functions.https.onRequest(async (req,res)=>{
    try {
        let customerId;
        //find customer
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
         });
        }
        const paymentIntent = await stripe.paymentIntents.create({
            amount:parseFloat(req.body.amount),
            currency: 'gbp',
            customer: customerId,
            application_fee_amount: 100,
            payment_method: req.body.payment_method_id,
            off_session: true,
            confirm: true,
            transfer_data:{
                transfer_data:req.body.connectedAccountId,
            }
          });
    } catch (error) {
        res.status(404).send({
            'status':'failed',
            "message":error.message,
         })
    }
})