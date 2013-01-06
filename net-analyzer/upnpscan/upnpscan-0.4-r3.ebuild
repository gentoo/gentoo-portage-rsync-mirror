# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/upnpscan/upnpscan-0.4-r3.ebuild,v 1.2 2012/10/09 10:07:01 pinkbyte Exp $

EAPI="4"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils

DESCRIPTION="Scans the network for UPNP capable devices"
HOMEPAGE="http://www.cqure.net/wp/upnpscan/"
SRC_URI="http://www.cqure.net/tools/${PN}-v${PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

PATCHES=( "${FILESDIR}/${P}-r2-cflags.patch" )
