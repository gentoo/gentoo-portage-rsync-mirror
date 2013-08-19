# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/semantik/semantik-0.8.4.ebuild,v 1.1 2013/08/19 17:09:24 kensington Exp $

EAPI=5

CMAKE_REQUIRED="never"
NO_WAF_LIBDIR="true"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="xml"
inherit python-single-r1 flag-o-matic kde4-base multilib toolchain-funcs waf-utils

DESCRIPTION="Mindmapping-like tool for document generation."
HOMEPAGE="http://freehackers.org/~tnagy/semantik.html"
SRC_URI="https://semantik.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
"
RDEPEND="${DEPEND}"

#WAF_BINARY="${S}/waf"

DOCS=( ChangeLog README TODO )
PATCHES=( "${FILESDIR}/${PN}"-0.8.3-wscript_ldconfig.patch )

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
	append-ldflags -Wl,--soname=libnablah.so.0
}

src_install() {
	waf-utils_src_install
	dosym libnablah.so /usr/$(get_libdir)/libnablah.so.0
}
