Referral Fee Hook Purpose: Rewards users who bring new traders or LPs into the pool.

How it works: Referrers get a small percentage of the swap fee every time their referred users trade or add liquidity. Example Use Case: Incentivizes organic growth through word-of-mouth promotion.

##SETUP

1. use this guide to setup project https://docs.uniswap.org/contracts/v4/quickstart/hooks/setup
2. forge install
3. anvil --gas-limit 12000000
4. forge script script/PointsHookDeploy.s.sol --rpc-url 127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
5. forge test
