# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbtbb/libbtbb-0.7.ebuild,v 1.1 2011/11/23 17:04:42 binki Exp $

EAPI=4

inherit multilib

DESCRIPTION="A library to decode Bluetooth baseband packets"
HOMEPAGE="http://libbtbb.sourceforge.net/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.code.sf.net/p/libbtbb/code"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include
	emake LDCONFIG=true DESTDIR="${D}" INSTALL_DIR="${ED}/usr/$(get_libdir)" INCLUDE_DIR="${ED}/usr/include" install
}
