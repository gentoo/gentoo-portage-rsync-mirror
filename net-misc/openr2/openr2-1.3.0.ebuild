# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openr2/openr2-1.3.0.ebuild,v 1.1 2010/05/13 11:29:44 chainsaw Exp $

EAPI=3
inherit autotools base

DESCRIPTION="An open implementation of the MFC/R2 telephony signaling protocol."
HOMEPAGE="http://libopenr2.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-misc/dahdi"
PATCHES=( "${FILESDIR}/${PV}-respect-user-cflags.patch" )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
