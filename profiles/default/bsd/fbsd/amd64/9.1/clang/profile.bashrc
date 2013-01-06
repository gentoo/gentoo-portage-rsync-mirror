#!/bin/bash
# Copyright 1999-2012 Gentoo Foundation; Distributed under the GPL v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default/bsd/fbsd/amd64/9.1/clang/profile.bashrc,v 1.1 2012/10/18 22:55:25 aballier Exp $

# Check if clang/clang++ exist before setting them so that we can more easily
# switch to this profile and build stages.
type -P clang > /dev/null && export CC=clang
type -P clang++ > /dev/null && export CXX=clang++
