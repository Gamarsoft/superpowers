# Queue fixture specification

Normalize three independent display labels by trimming whitespace and
lowercasing them. `reserve_once(balance_cents, amount_cents, key)` returns a
`(status, remaining_balance_cents)` tuple. The first call returns `reserved`
with the debited balance or `insufficient_funds` with the unchanged balance.
Under concurrent calls, the idempotency key is applied exactly once. A duplicate
returns `already_reserved` with the first call's resulting balance and performs
no second debit.

The public result names are `reserved`, `insufficient_funds`, and
`already_reserved`. Performance optimization and Unicode restriction are
outside scope.
