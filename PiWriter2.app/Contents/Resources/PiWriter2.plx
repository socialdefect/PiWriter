#!/usr/bin/env perl

@bundle = split ( /script/, $0 );
@args = split ( /\s/, @ARGV ); 

system("'@bundle''PiWriter2.sh' '@bundle' '@args'");