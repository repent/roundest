# roundest

A gem for finding the roundest number between two floats.

Roundest returns its own class of number, Floteger, in order to preserve its roundness.  It is intended to be used when you are ultimately looking for pretty, i.e. string output rather than for further computation.

## Install

    sudo gem install roundest

## Use

    require 'roundest'

    Roundest::roundest(0.00371, 0.00379).to_s
    => "0.00375"

## Licence

Copyright Dan Hetherington 2018, released under the GPL 3.0.