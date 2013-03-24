# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unix-Getrusage/Unix-Getrusage-0.030.0.ebuild,v 1.1 2013/03/24 16:16:08 pinkbyte Exp $

EAPI=5

MODULE_AUTHOR=TAFFY
MODULE_VERSION=0.03

inherit perl-module

DESCRIPTION="Perl interface to the Unix getrusage system call"

SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_TEST="do parallel"
