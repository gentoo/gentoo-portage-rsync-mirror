# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxcl/nxcl-0.9-r1.ebuild,v 1.3 2012/05/21 19:14:40 xarthisius Exp $

inherit autotools eutils

MY_P="freenx-client-${PV}"
DESCRIPTION="A library for building NX clients"
HOMEPAGE="http://developer.berlios.de/projects/freenx/"
SRC_URI="mirror://berlios/freenx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dbus doc nxclient"

RDEPEND=">=net-misc/nx-3.2.0-r5
	dbus? ( sys-apps/dbus )
	nxclient? ( net-misc/nxclient )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"
S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use nxclient; then
		# Patch to use standard ssh instead of nxssh from nxclient
		epatch "${FILESDIR}"/${P}-no_nxssh.patch
	fi
	epatch "${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_compile() {
	econf $(use_with doc doxygen) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
