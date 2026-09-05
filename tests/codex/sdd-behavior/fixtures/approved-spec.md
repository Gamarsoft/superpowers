# Queue fixture specification

Normalize three independent display labels by trimming whitespace and
lowercasing them. Reserve integer cents exactly once per idempotency key under
concurrent calls. A duplicate reservation returns the first result without a
second debit.

The public result names are `reserved`, `insufficient_funds`, and
`already_reserved`. Performance optimization and Unicode restriction are
outside scope.
