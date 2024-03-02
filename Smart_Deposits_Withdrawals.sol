//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

contract Smart_Deposits_Withdrawals {
    struct Transaction{
        uint amount;
        uint timestamp;
    }
    
    struct Balance{
        uint totalBalance;
        mapping(uint => Transaction) deposits;
        uint numDeposits;
        mapping(uint => Transaction) withdrawals;
        uint numWithdrawals;

    }
    
    mapping(address => Balance) public balances;

    function deposit() public payable{
        balances[msg.sender].totalBalance += msg.value;
        Transaction memory deposit = Transaction(msg.value,block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;
        balances[msg.sender].numDeposits++;
    }

    function withdrawal(address payable _to, uint amount) public payable{
        balances[_to].totalBalance -= amount;
        Transaction memory withdrawal = Transaction(amount,block.timestamp);
        balances[_to].withdrawals[balances[_to].numWithdrawals] = withdrawal;
        balances[msg.sender].numWithdrawals++;

        _to.transfer(amount);
    }

    function getbalance() public view returns(uint){
        return address(this).balance;
    }
}
