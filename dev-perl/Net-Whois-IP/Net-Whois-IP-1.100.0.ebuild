# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Whois-IP/Net-Whois-IP-1.100.0.ebuild,v 1.1 2012/11/19 18:37:39 zerochaos Exp $

EAPI=4

MODULE_VERSION=${PV%0.0}
MODULE_AUTHOR=BSCHMITZ
inherit perl-module

DESCRIPTION="Perl extension for looking up the whois information for ip addresses"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

SRC_TEST="online"
