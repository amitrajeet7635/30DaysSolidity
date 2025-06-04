# Problem Statement:
In this problem we need to create a system which allow operations only for the admin and admin can control all the operations. It is a treasury system where admin can add amount to the chest and specific user/addresses selected by admin can only withdrawn amount from the chest. Also we need to implement a feature where if a user have withdrawn an amount once they cannot withdrawn anymore. Alongside we need to add few more features like transfering ownership and reset the chest.

# My Approach:
To complete this problem I used the concept of modifiers and access specifiers. I used modifiers to check if the user has already withdrawn the amount or not. Mapping was also a concept used to solve the issue to set the users hasWithdrawn status to a boolean value. Apart from this I used msg.sender to get the current address and then pass it through the modifer and functions in order to complete the solution of the problem. 

### You can check my source code and let me know if there is a better way to solve the problem in more gas cost efficient way.