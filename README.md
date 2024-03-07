# Liquidity Bootstrapping

This repo is an entry into the Immutable Hitathon 2024.

## Initial Concept

Indy games want to release an ERC 20 token, a game coin. The token will have some utility in the game. It does not show ownership of the game. Maybe the token is used to do governance to decide on new game features. 

Additionally, the game dev team wants to have a coin as a way to capture some income. They have this as part of the strategy for making money.

Importantly, they want the coin to be tradable on DEXes.

However, on Immutable zkEVM, we are using QuickSwap, which supports two sided Uniswap V3 pools (and not single sided V4 pools).

Pricing a token is very tricky. How does the team work out what it is worth?

What the team could do is have a contract, that sells tokens at an inflationary price schedule. That is, for the first 1000 tokens, they are sold at $0.001, and then the price ramps to what the game thinks would be an appropriate price. (edited) 

However, what if the game has got the target price wrong?

So, what the contract could do is have the price for the tokens go up (and down?), or maybe have the rate that they go up determined by how much interest there is. That is, if there are lots of people, say one request each five blocks, then ramp the price quickly, but if no one has asked for tokens in the last 24 hours, then maybe decrease the asking price.

Once there is enough IMX (or whatever the token is that the coin needs to be bought in), move the liquidity to an AMM pool on QuickSwap. (edited) 

The design task I think is to work out what type of pricing function there should be.

A separate piece of this is to set-up an initial price indicator. How this could be done is to have a planned airdrop of tokens to people. Allow people to know ahead of time how many tokens they will have. Then have a "futures" contract, in which air drop recipients can list their tokens for sale before they have received them. They would need to lodge a deposit to make sure they don't fail to deliver their tokens after the airdrop. Buyers would agree to buy the tokens to be airdropped by putting in a deposit. Then, when the airdrop happens, the air drop recipient must submit their tokens to the contract and the buyers must submit their IMX. Both sides get their deposits back.

What all this leads to is, air drop recipients can seed the market expectations of price by offering to sell their air dropped tokens in the "futures" contract. Then, after the airdrop, other people who arrive later can buy the tokens using the special inflationary contract. Then, once enough liquidity has been raised. people can buy and sell the game token on the DEX freely.

## Build
See [build instructions](./BUILD.md).