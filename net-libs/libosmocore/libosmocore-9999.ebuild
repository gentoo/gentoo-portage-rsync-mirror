# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosmocore/libosmocore-9999.ebuild,v 1.5 2013/11/05 13:31:39 chithanh Exp $

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Utility functions for OsmocomBB, OpenBSC and related projects"
HOMEPAGE="http://bb.osmocom.org/trac/wiki/libosmocore"
EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="embedded"

RDEPEND=""
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_prepare() {
	# set correct version in pkgconfig files
	sed -i "s/UNKNOWN/${PV}/" git-version-gen || die

	epatch "${FILESDIR}"/${PN}-0.6.0-automake-1.13.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable embedded)
}

src_install() {
	default
	# install to correct documentation directory
	mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${PF} || die
}
