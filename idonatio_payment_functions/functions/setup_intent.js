const functions = require('firebase-functions');
const stripe = require('stripe')('sk_test_51HSkkpGqiuzQS1fhEtX8bsYNlX0UrTfMQZo4ZD7gu9L20BIKZMwwLqg5zfhQrLhZ8f1kCxZvhhIjS8Itk0ycrWBS00LPzSpdFv');


exports.stripeSetUpIntent = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;

        //Gets the customer who's email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1
        });

        //Checks the if the customer exists, if not creates a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        }
        else {
            const customer = await stripe.customers.create({
                email: req.body.email
            });
            customerId = customer.data.id;
        }

        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        ); const setupIntent = await stripe.setupIntents.create({
            customer: customerId,
        });
        res.status(200).send(
            {
                setupIntent: setupIntent.client_secret,
                ephemeralKey: ephemeralKey.secret,
                customer: customerId,
            }
        )
    } catch (error) {
        res.status(404).send(error.message)
    }
})