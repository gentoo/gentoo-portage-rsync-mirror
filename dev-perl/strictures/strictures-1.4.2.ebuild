# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/strictures/strictures-1.4.2.ebuild,v 1.1 2012/09/10 18:01:12 tove Exp $

EAPI=4

MODULE_AUTHOR=ETHER
MODULE_VERSION=1.004002
inherit perl-module

DESCRIPTION="Turn on strict and make all warnings fatal"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"

SRC_TEST=do
