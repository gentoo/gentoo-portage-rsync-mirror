# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNPP/Net-SNPP-1.170.0.ebuild,v 1.2 2011/09/03 21:04:43 tove Exp $

EAPI=4

MODULE_AUTHOR=TOBEYA
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="libnet SNPP component"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="virtual/perl-libnet"
