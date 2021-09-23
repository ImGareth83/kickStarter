import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
  JSON.parse(CampaignFactory.interface),
  '0x4e822487fA6E1ed75bf13e3A6eF46Ba32ec48260');

export default instance;
