import { APIGatewayProxyHandler } from 'aws-lambda';
import 'source-map-support/register';
import getTokenCredentials from "./secret";
import Web3 from "web3";
const snftABI = require('./abi.json');

export const snt1: APIGatewayProxyHandler = async (lambdaEvent, context) => {
  context.callbackWaitsForEmptyEventLoop = false;

  let statusCode = 200;
  let message;
  try {
    const t = await getTokenCredentials();
    const tObj = JSON.parse(t);
    const testnet = `${process.env.INFURA_URL}${tObj.PROVIDER_ACCESS_TOKEN}`;
    const web3 = new Web3(new Web3.providers.HttpProvider(testnet));
    web3.eth.defaultAccount = tObj.OWNER_ADDRESS;
    const wallet = web3.eth.defaultAccount;
    const theContract = new web3.eth.Contract(snftABI, tObj.NFT_CONTRACT_ADDRESS);
    const metaDataHash = await theContract.methods.tokenURI('001').call({from: wallet});
    message = metaDataHash;
  } catch (error) {
    // eslint-disable-next-line
    console.log(`error ${JSON.stringify(error)}`);
    statusCode = 500;
    message = JSON.stringify(error);
  }

  return {
    statusCode,
    body: message,
  };
};
