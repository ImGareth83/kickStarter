pragma solidity ^0.4.17;

contract CampaignFactory{
    address[] public deployedCampaigns;

    function createCampaign(uint minimum)public{
        address newCampaign = new Campaign(minimum, msg.sender);
        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaigns()public view returns (address[]){
        return deployedCampaigns;
    }

}

contract Campaign{

  address public manager;
  uint public minimumContribution;
  mapping(address => bool) public approvers;
  Request[] public requests;
  uint public approversCount;

  modifier restricted(){
      require(msg.sender == manager);
      _;
  }

  constructor (uint minimum,address creator) public{
      manager=creator;
      minimumContribution=minimum;
  }

  struct Request{
      string description;
      uint value;
      address recipient;
      bool complete;
      mapping(address => bool) approvals;
      uint approvalCount;
  }

  function contribute () public payable{
      require(msg.value>minimumContribution,'Must be greater minimumContribution');
      approvers[msg.sender]=true;
      approversCount++;
  }

  function createRequest(string description, uint value, address recipient) public payable restricted {
      //require(approvers[msg.sender]);

      //memory(refers to new instance) vs storage (refer to the same instance)
      Request memory newRequest = Request({
          description:description,
          value:value,
          recipient:recipient,
          complete:false,
          approvalCount:0
      });

      requests.push(newRequest);
  }

  function approveRequest(uint index) public payable{
      require(approvers[msg.sender]);

      Request storage req = requests[index];

      require(!req.approvals[msg.sender]);
      req.approvalCount++;
      req.approvals[msg.sender]=true;

  }

  function finalizeRequest(uint index) public payable restricted {
      Request storage req = requests[index];
      require(req.approvalCount>(approversCount/2));
      require(!req.complete);

      req.recipient.transfer(req.value);

      req.complete=true;

  }

  function getSummary() public view returns(uint,uint,uint,uint,address){

    return (
      minimumContribution,
      this.balance,
      requests.length,
      approversCount,
      manager
    );

  }

  function getRequestsCount() public view returns(uint){
    return requests.length;
  }

}
