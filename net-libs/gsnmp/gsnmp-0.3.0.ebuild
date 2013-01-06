# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gsnmp/gsnmp-0.3.0.ebuild,v 1.8 2012/11/10 08:19:44 pinkbyte Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="An SNMP library based on glib and gnet"
HOMEPAGE="ftp://ftp.ibr.cs.tu-bs.de/pub/local/gsnmp/"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~amd64-linux ~ppc x86"
IUSE="static-libs"

DEPEND="
	dev-libs/glib:2
	net-libs/gnet
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-g_access.patch )

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( README )
