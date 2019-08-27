const {
  shouldFail,
  constants,
  expectEvent,
  BN
} = require('openzeppelin-test-helpers');
const { expect } = require('chai');

const CrowdsaleTokenFactory = artifacts.require('CrowdsaleToken');

contract('CrowdsaleToken', accounts => {
  const [owner, user, sender, receiver, ...others] = accounts;

  describe('#constructor()', async () => {
    it('should successfully initialize', async () => {
      const CrowdsaleToken = await CrowdsaleTokenFactory.new();
      expect(await CrowdsaleToken.currentStage())
        .to.be.bignumber.equal(new BN(0));
      expect(await CrowdsaleToken.totalSupply())
        .to.be.bignumber.equal(new BN('1000000').mul(new BN('10').pow(new BN('18'))));
      expect(await CrowdsaleToken.balanceOf(owner))
        .to.be.bignumber.equal(new BN('1000000').mul(new BN('10').pow(new BN('18'))));
      expect(await CrowdsaleToken.remainingTokens())
        .to.be.bignumber.equal(new BN('1000000').mul(new BN('10').pow(new BN('18'))));
    });

    it('should emit Transfer event', async () => {
      const CrowdsaleToken = await CrowdsaleTokenFactory.new();
      const { blockNumber } = await web3.eth.getTransactionReceipt(CrowdsaleToken.transactionHash);
      const eventList = await CrowdsaleToken.getPastEvents('allEvents', {
        fromBlock: blockNumber,
        toBlock: blockNumber,
      });
      expectEvent.inLogs(eventList, 'Transfer', {
        from: CrowdsaleToken.address,
        to: owner,
        value: new BN('1000000').mul(new BN('10').pow(new BN('18')))
      })
    })
  });

  describe('After Initialization', () => {
    let CrowdsaleToken;

    beforeEach(async () => {
      CrowdsaleToken = await CrowdsaleTokenFactory.new();
    });
  });
});
