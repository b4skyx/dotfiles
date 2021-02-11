#!/bin/sh

i3lock -n -e                    \
    --linecolor=00000000        \
    --keyhlcolor=88c0d0ff       \
    --bshlcolor=bfddb2ff	\
    --separatorcolor=00000000   \
    --radius=200		\
    \
    --insidevercolor=00000000	\
    --insidewrongcolor=00000000 \
    --insidecolor=00000000	\
    \
    --ringcolor=a89984ff        \
    --ringvercolor=b16286ff     \
    --ringwrongcolor=bf616aff   \
    \
    --clock			\
    --timecolor=eceff4ff	\
    --timestr="%H:%M"		\
    --time-font=Canatell		\
    --timesize=80		\
    \
    --datecolor=bfddb2ff	\
    --datestr="%A, %d %B"	\
    --date-font=Canatell		\
    --datesize=20		\
    --datepos="tx:600"		\
    \
    --veriftext="Verifying..."	\
    --verif-font=Canatell		\
    --verifcolor=bfddb2ff	\
    --verifsize=45		\
    \
    --wrongtext="Incorrect"	\
    --wrong-font=Canatell		\
    --wrongcolor=bfddb2ff	\
    --wrongsize=45		\
    \
    --indicator			\
    --color=2a2f33
