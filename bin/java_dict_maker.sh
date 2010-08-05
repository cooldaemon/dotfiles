#!/bin/sh
jar tf /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Classes/classes.jar | grep '.class' | egrep '^java/(io|util)' | sort | perl -anle '$F[0] =~ s/\.class$//; $F[0] =~ s{/}{.}g; print $F[0]'
