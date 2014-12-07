# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/strictures/strictures-1.4.4-r1.ebuild,v 1.3 2014/12/07 12:57:33 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ETHER
MODULE_VERSION=1.004004
inherit perl-module

DESCRIPTION="Turn on strict and make all warnings fatal"

SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ppc x86 ~ppc-aix ~ppc-macos ~x86-solaris"

SRC_TEST=do
