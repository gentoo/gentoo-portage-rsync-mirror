# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ccrtp/ccrtp-2.0.5.ebuild,v 1.2 2013/07/30 09:07:33 ago Exp $

EAPI=4
inherit eutils multilib

DESCRIPTION="GNU ccRTP is an implementation of RTP, the real-time transport protocol from the IETF"
HOMEPAGE="http://www.gnu.org/software/ccrtp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
LICENSE="GPL-2"
IUSE="doc"
SLOT="0"

RDEPEND=">=dev-cpp/commoncpp2-1.3.0
	dev-libs/libgcrypt
	>=dev-libs/ucommon-5.0.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	econf --disable-static
}

src_install() {
	default
	prune_libtool_files
	use doc && dohtml -r doc/html/*
}

pkg_postinst() {
	if [[ -e "${ROOT}"/usr/$(get_libdir)/libccrtp1-1.4.so.0 ]] ; then
		elog "Please run: revdep-rebuild --library libccrtp1-1.4.so.0"
	fi
	if [[ -e "${ROOT}"/usr/$(get_libdir)/libccrtp1-1.5.so.0 ]] ; then
		elog "Please run: revdep-rebuild --library libccrtp1-1.5.so.0"
	fi
	if [[ -e "${ROOT}"/usr/$(get_libdir)/libccrtp1-1.6.so.0 ]] ; then
		elog "Please run: revdep-rebuild --library libccrtp1-1.6.so.0"
	fi
}
