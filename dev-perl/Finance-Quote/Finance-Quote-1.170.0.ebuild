# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.170.0.ebuild,v 1.2 2012/03/25 15:17:38 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ECOCODE
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="Get stock and mutual fund quotes from various exchanges"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Tree
	dev-perl/HTML-TableExtract
	dev-perl/Crypt-SSLeay"
RDEPEND="${DEPEND}"

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/VWD.pm.diff )
