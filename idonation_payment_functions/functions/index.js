
const setUpIntent = require('./setup_intent.js');
const getCustomerPaymentMethods = require('./get_customer_payment_methods.js');
//
exports.setUpIntent = setUpIntent.stripeSetUpIntent;
exports.getCustomerPaymentMethods = getCustomerPaymentMethods.getCustomerPaymentMethods;
