! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays combinators io kernel locals math random prettyprint sequences ;
IN: 24game

! BELOW CODE WRITTEN BY COLE
:: 24-next  ( seq -- {seq1,seq2,seq3,seq4} )
  seq first     :> fst
  seq second    :> snd
  seq rest rest :> rst
  4 rst <repetition> fst snd + fst snd - fst snd * fst snd / 4array [ 1array ] map [ swap append ] 2map ;

: 24-solvable? ( {x1,...,xn} -- ? ) dup length 1 = [ first 24 = ] [ 24-next [ 24-solvable? ] any? ] if ;

! BELOW CODE WRITTEN BY CAMERON
: rint ( -- n ) { 1 2 3 4 5 6 7 8 9 } random ;

: rseq ( -- seq ) rint rint rint rint 4array ;

: get-puzzle ( -- seq ) rseq dup 24-solvable? [ "done" print ] [ "recurse" print drop get-puzzle ] if ;

! BELOW CODE WRITTEN BY NANDEEKA
: print-prompt ( seq -- seq )
    dup pprint
    "\nOperators: { + - * / }" print ;

: prepare-compute ( seq str -- seq a b )
    drop dup reverse first2 swap ;

: replace-elem ( seq x -- seq )
    [ dup length 2 - head ] dip
    1array append ;

: play-round ( seq -- seq )
    print-prompt
    readln
    {
        { [ dup "+" = ] [ prepare-compute + replace-elem ] }
        { [ dup "-" = ] [ prepare-compute - replace-elem ] }
        { [ dup "*" = ] [ prepare-compute * replace-elem ] }
        { [ dup "/" = ] [ prepare-compute / replace-elem ] }
        [ drop "Operator not found..." print ]
    } cond ;

: finish-game ( seq -- seq )
    dup first 24 = [ "You won!" print ] [ "You lost!" print ] if ;

: play-game ( seq -- seq )
    dup length 1 = [ finish-game ] [ play-round play-game ] if ;

: 24game ( -- ) get-puzzle play-game drop ;
