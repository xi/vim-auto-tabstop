A Vim plugin for automatically setting tabstop size

This is mostly useful to align tsv files like this:

    James\tSmith\t38,313
    Michael\tSmith\t34,810
    Robert\tSmith\t34,269
    Maria\tGarcia\t32,092 (long string in last column is ignored)

With a tabstop of 2 this will look like this:

    James Smith 38,313
    Michael Smith 34,810
    Robert  Smith 34,269
    Maria Garcia  32,092 (long string in last column is ignored)

Pressing `<c-t>` will automatically set the tabstop to the value required to
get proper alignment (in this case 8):

    James   Smith   38,313
    Michael Smith   34,810
    Robert  Smith   34,269
    Maria   Garcia  32,092 (long string in last column is ignored)
