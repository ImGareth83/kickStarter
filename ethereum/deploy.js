const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');

// const {interface,bytecode} = require('./compile');
const compiledFactory = require('../ethereum/build/CampaignFactory.json');

const provider = new HDWalletProvider(
  'stand estate service sauce rocket soul dust spray address orange carpet dinosaur',
  'https://rinkeby.infura.io/v3/42ca43a246654d79939cd96929650cc7'
);

const web3 = new Web3(provider);

const deploy = async ()=>{
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account',accounts[0]);

  const result = await new web3.eth.Contract(JSON.parse(compiledFactory.interface))
  .deploy({data:compiledFactory.bytecode})
  .send({gas:'1000000',gasPrice: '5000000000',from:accounts[0]});

  // console.log(compiledFactory.interface);
  console.log('Contract deploy to', result.options.address);
  //0x3629289325e78A7fFCed77554fB33d2d23D116a9
};

deploy();
