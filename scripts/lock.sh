#!/bin/sh

i3lock -n -e                    \
    --linecolor=00000000        \
    --keyhlcolor=88c0d0ff       \
    --bshlcolor=d8dee9ff	\
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
    --datecolor=d8dee9ff	\
    --datestr="%A, %d %B"	\
    --date-font=Canatell		\
    --datesize=20		\
    --datepos="tx:600"		\
    \
    --veriftext="Verifying..."	\
    --verif-font=Canatell		\
    --verifcolor=d8dee9ff	\
    --verifsize=45		\
    \
    --wrongtext="Incorrect"	\
    --wrong-font=Canatell		\
    --wrongcolor=d8dee9ff	\
    --wrongsize=45		\
    \
    --indicator			\
    --color=32302f
