# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nget/nget-0.27.1.ebuild,v 1.12 2010/04/06 18:21:05 abcd Exp $

EAPI="3"

inherit flag-o-matic eutils

DEB_VER="10"
DEB_PATCH="${PN}_${PV}-${DEB_VER}.diff"
DESCRIPTION="Network utility to retrieve files from an NNTP news server"
HOMEPAGE="http://nget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://debian/pool/main/n/nget/${DEB_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc sh x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="static debug ipv6 pcre zlib"
RESTRICT="test"

RDEPEND="dev-libs/popt
	pcre? ( dev-libs/libpcre )
	zlib? ( sys-libs/zlib )"
DEPEND="dev-libs/uulib"

src_prepare() {
	EPATCH_OPTS="-p1" epatch "${WORKDIR}"/${DEB_PATCH}
	epatch debian/patches/*.patch "${FILESDIR}"/${P}-headers.patch
	sed -i '/^install_bin/s:-s::' Makefile.in
}

src_configure() {
	use static && append-flags -static

	[[ ${CHOST} == *-darwin* ]] && append-flags -D__STDC_CONSTANT_MACROS

	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with pcre) \
		$(use_with zlib)
}

src_install() {
	emake -j1 \
		prefix="${ED}"/usr \
		mandir="${ED}"/usr/share/man \
		infodir="${ED}"/usr/share/info \
		install || die "install failed"

	dodoc Changelog FAQ README TODO
	newdoc .ngetrc ngetrc.sample
}
