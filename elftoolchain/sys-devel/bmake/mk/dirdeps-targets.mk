# RCSid:
#       $Id: dirdeps-targets.mk,v 1.5 2019/10/02 19:16:05 sjg Exp $
#
#       @(#) Copyright (c) 2019 Simon J. Gerraty
#
#       This file is provided in the hope that it will
#       be of use.  There is absolutely NO WARRANTY.
#       Permission to copy, redistribute or otherwise
#       use this file is hereby granted provided that 
#       the above copyright notice and this notice are
#       left intact. 
#      
#       Please send copies of changes and bug-fixes to:
#       sjg@crufty.net
#

##
# This makefile is used to set initial DIRDEPS for top-level build
# targets.
#
# The basic idea is that we have a list of directories in
# TARGETS_DIRS which are relative to SRCTOP.
# When asked to make 'foo' we look for any directory named 'foo'
# under TARGETS_DIRS.
# We then search those dirs for any Makefile.depend*
# Finally we select any that match conditions like REQUESTED_MACHINE
# or TARGET_SPEC and initialize DIRDEPS accordingly.
# 

.if ${.MAKE.LEVEL} == 0
# pickup customizations
.-include <local.dirdeps-targets.mk>

# for DIRDEPS_BUILD this is how we prime the pump
TARGETS_DIRS ?= targets targets/pseudo
# these prefixes can modify how we behave
# they need to be stripped when looking for target dirs
TARGETS_PREFIX_LIST ?= pkg- build-

# matching target dirs if any
tdirs := ${.TARGETS:Nall:${TARGETS_PREFIX_LIST:@p@S,^$p,,@:ts:}:@t@${TARGETS_DIRS:@d@$d/$t@}@:@d@${exists(${SRCTOP}/$d):?$d:}@}

.if !empty(DEBUG_DIRDEPS_TARGETS)
.info tdirs=${tdirs}
.endif

.if !empty(tdirs)
# raw Makefile.depend* list
tdeps != 'cd' ${SRCTOP} && 'ls' -1 ${tdirs:O:u:@d@$d/${.MAKE.DEPENDFILE_PREFIX}*@} 2> /dev/null; echo

# plain entries (no qualifiers) these apply to any TARGET_SPEC
ptdeps := ${tdeps:M*${.MAKE.DEPENDFILE_PREFIX}:S,/${.MAKE.DEPENDFILE_PREFIX},,}

# MACHINE qualified entries
PSEUDO_MACHINE_LIST ?= common host host32
mqtdeps := ${${ALL_MACHINE_LIST} ${PSEUDO_MACHINE_LIST} ${TARGET_MACHINE_LIST}:L:O:u:@m@${tdeps:M*.$m}@:S,/${.MAKE.DEPENDFILE_PREFIX},,}

.if ${TARGET_SPEC_VARS:[#]} > 1
# TARGET_SPEC qualified entries
tqtdeps := ${TARGET_SPEC_LIST:U:O:u:@t@${tdeps:M*.$t}@:S,/${.MAKE.DEPENDFILE_PREFIX},,}
.else
tqtdeps =
.endif

# now work out what we want in DIRDEPS
.if defined(ALL_MACHINES)
# expand plain entries for all TARGET_SPEC/MACHINES
# ALL_MACHINES_LIST (not ALL_MACHINE_LIST) is what we want here
ALL_MACHINES_LIST ?= ${ALL_TARGET_SPEC_LIST} ${ALL_MACHINE_LIST}
DIRDEPS = ${ALL_MACHINES_LIST:O:u:@m@${ptdeps:@d@$d.$m@}@} ${mqtdeps} ${tqtdeps}
.elif empty(REQUESTED_MACHINE)
# we want them all just as found
DIRDEPS = ${ptdeps} ${mqtdeps} ${tqtdeps}
.else
# we only want those that match REQUESTED_MACHINE
# or REQUESTED_TARGET_SPEC (TARGET_SPEC)
DIRDEPS = ${ptdeps:@d@$d.${REQUESTED_MACHINE}@} ${mqtdeps:M*.${REQUESTED_MACHINE}} ${tqtdeps:M*.${REQUESTED_TARGET_SPEC:U${TARGET_SPEC}}}
.if empty(REQUESTED_TARGET_SPEC)
DIRDEPS += ${tqtdeps:M*.${REQUESTED_MACHINE},*}
.endif
.endif
# clean up
DIRDEPS := ${DIRDEPS:O:u}

.if !empty(DEBUG_DIRDEPS_TARGETS)
.for x in tdeps ptdeps mqtdeps tqtdeps DIRDEPS
.info $x=${$x}
.endfor
.endif
.endif
# if we got DIRDEPS get to work
.if !empty(DIRDEPS)
.include <dirdeps.mk>

DIRDEPS_TARGETS_SKIP += all clean* destroy*

.for t in ${.TARGETS:${DIRDEPS_TARGETS_SKIP:${M_ListToSkip}}}
$t: dirdeps
.endfor                                                                         
.endif
.endif
