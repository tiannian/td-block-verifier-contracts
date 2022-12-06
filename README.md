# td-block-verifier

Validate tendermint block in solidity

## Verifying tendermint block

Need these `Consensus Argument`s:

1. Validator Set
2. Block Height
3. Block Hash
4. App Hash

Flow of verifying:

1. Verify `Vote` signatures based on `Validator Set`.
2. Use all `Vote Hash`es to verify `Vote Bytes`.
3. Decode `Block Hash` from `Vote bytes`.
4. Decode `Block Header` from `Block Bytes`.
5. Use `Block Hash` to verify `Block Header`.
6. Decode `Validator Set` from `Block Header` and set to `Consensus Argument`.

Over 67% power is ok, continue.

## Reference



