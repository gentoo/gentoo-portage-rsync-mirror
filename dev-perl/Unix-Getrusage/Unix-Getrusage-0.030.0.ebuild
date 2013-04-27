# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unix-Getrusage/Unix-Getrusage-0.030.0.ebuild,v 1.3 2013/04/27 18:42:12 ago Exp $

EAPI=5

MODULE_AUTHOR=TAFFY
MODULE_VERSION=0.03

inherit perl-module

DESCRIPTION="Perl interface to the Unix getrusage system call"

SLOT="0"
KEYWORDS="amd64 x86"

SRC_TEST="do parallel"
