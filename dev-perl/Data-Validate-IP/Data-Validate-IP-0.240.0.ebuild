# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Validate-IP/Data-Validate-IP-0.240.0.ebuild,v 1.2 2014/12/07 13:26:46 zlogene Exp $

EAPI=5

MODULE_AUTHOR="DROLSKY"
MODULE_VERSION="0.24"

inherit perl-module

DESCRIPTION="Lightweight IPv4 and IPv6 validation module."

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-perl/NetAddr-IP-4.66.0
	dev-perl/Test-Requires"
