<a name="v1.1.0"></a>
## v1.2.0 (2017-12-7)


#### Features

* **invoices**
  *  add filters to invoice find_all method ((d8588ea))
*   Create method to generate OAuth token ((cc5dcad7))
* **Accounts**
  *  added `create` method and Account resource ((a8ec5469))
  *  added `create` method and Account resource ((399b49b9))
* **Balances**  added initial support ( `show`) ((8b46be43))
* **Connect**  Create method to generate authorize url ((8fcbd67d))
* **Customer**
  *  Overload method to delete credit card ((1b920029))
  *  Create method to delete a credit card from customer ((71e1b6a9))
  *  Create method to add credit card to customer ((edc5c67e))
* **MultiPayment**
  *  added `void` ((c7eb0a99))
  *  added `.capture` ((a8b4fcbc))
* **Notifications**
  *  Add method to delete a notification preference ((79354cb0))
  *  Add parameter to create notification to apps ((98735f0a))
  *  Add method to find all notification preferences ((c97383f0))
  *  Add method to get a notification ((7e853d6c))
  *  Add method to create notification preference ((80c09bbb))
* **Order**  added `q` param support for ownID searches ((24ba5138))
* **Payment**  Add show, void and capture methods to Payment ((4f266390))
* **accounts**
  *  added #show ((1da02bee))
  *  added #exists? ((e97fbd2d))
  *  added #show ((cebf937a))
  *  added #exists? ((d75ad84c))
* **api**
  *  add balances and entries APIs endpoints ((30d4b932))
  *  Added .accounts ((4ed3d625))
  *  Added .accounts ((74df6adb))
* **bank-accounts**
  *  add show, delete, update and find_all actions ((401c3ef6))
  *  add create action ((0afde060))
* **entries**  add action show and index ((3a95df1e))
* **order**
  *  added `filters` support to `find_all` ((55d3cb8b))
  *  added `find_all` ((7e66c07d))
* **response**
  *  added ability to handle non-json response payloads ((526e53d6))
  *  added ability to handle non-json response payloads ((593966ad))
* **webhooks**
  *  add webhooks endpoint ((f9247ceb))

#### Bug Fixes

* **Balances**  added needed `Accept` header ((bb928548))



<a name="1.0.0"></a>
## 1.0.0 (2017-09-26)


#### Features

*   Create method to generate OAuth token ((cc5dcad7))
* **Accounts**
  *  added `create` method and Account resource ((a8ec5469))
  *  added `create` method and Account resource ((399b49b9))
  *  added #show ((1da02bee))
  *  added #exists? ((e97fbd2d))
  *  added #show ((cebf937a))
  *  added #exists? ((d75ad84c))
* **Connect**  Create method to generate authorize url ((8fcbd67d))
* **Customer**
  *  Overload method to delete credit card ((1b920029))
  *  Create method to delete a credit card from customer ((71e1b6a9))
  *  Create method to add credit card to customer ((edc5c67e))
* **Notifications**
  *  Add method to delete a notification preference ((79354cb0))
  *  Add parameter to create notification to apps ((98735f0a))
  *  Add method to find all notification preferences ((c97383f0))
  *  Add method to get a notification ((7e853d6c))
  *  Add method to create notification preference ((80c09bbb))
* **Payment**  Add show, void and capture methods to Payment ((4f266390))
* **Api**
  *  Added .accounts ((4ed3d625))
* **Order**
  *  added `filters` support to `find_all` ((55d3cb8b))
  *  added `find_all` ((7e66c07d))
* **Response**
  *  added ability to handle non-json response payloads ((526e53d6))
