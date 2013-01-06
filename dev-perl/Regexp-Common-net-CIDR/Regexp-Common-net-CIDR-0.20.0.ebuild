# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Regexp-Common-net-CIDR/Regexp-Common-net-CIDR-0.20.0.ebuild,v 1.1 2012/02/03 17:20:30 tove Exp $

EAPI=4

MODULE_AUTHOR=RUZ
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Provides patterns for CIDR blocks"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/regexp-common
"
DEPEND="${RDEPEND}
"

SRC_TEST=do
