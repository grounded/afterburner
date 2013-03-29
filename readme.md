# Afterburner Framework

[![Code Climate](https://codeclimate.com/github/grounded/afterburner.png)](https://codeclimate.com/github/grounded/afterburner)

The building blocks for the Rails Engine universe.  All the stuff that all of
our projects do over and over and in slightly different ways.

This is a base framework that exposes some useful tools and tries to heal pain
points of integrations. For example `will_paginate` and `kaminari` clash so
there's a protocol/adapter system to try to prevent that.

This is also a work in progress.

## Development
To run the tests:

    rspec spec
