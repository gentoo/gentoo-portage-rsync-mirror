#!/bin/bash
# Copyright 1999-2013 Gentoo Foundation; Distributed under the GPL v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default/bsd/fbsd/amd64/9.2/clang/profile.bashrc,v 1.1 2013/08/09 14:11:22 aballier Exp $

# Check if clang/clang++ exist before setting them so that we can more easily
# switch to this profile and build stages.
type -P clang > /dev/null && export CC=clang
type -P clang++ > /dev/null && [ -f /usr/lib/libc++.so ] && export CXX="clang++ -stdlib=libc++"
