# Problem Statement:
Create a piggy bank, in which we have a bank manager and every user will be registered by the bank manager. We need to make sure that only the registered user can add funds and withdraw funds from the bank. Also the smart contract should be able to run and transact the function for real ether as well.

# My Approach:
I used payable and msg.value in order to make the transaction using real ether, also used modifier to add a check that only bankManager can make the user registered and only the registered users can transact money in the bank. 