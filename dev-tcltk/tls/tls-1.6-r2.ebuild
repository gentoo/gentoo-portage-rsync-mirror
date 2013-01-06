# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tls/tls-1.6-r2.ebuild,v 1.8 2011/01/13 20:11:28 xarthisius Exp $

EAPI="3"

inherit eutils multilib

MY_P="${PN}${PV}"

DESCRIPTION="TLS OpenSSL extension to Tcl."
HOMEPAGE="http://tls.sourceforge.net/"
SRC_URI="mirror://sourceforge/tls/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="tk"

DEPEND="
	dev-lang/tcl
	dev-libs/openssl
	tk? ( dev-lang/tk )"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--with-ssl-dir="${EPREFIX}/usr" \
		--with-tcl="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README.txt || die
	dohtml tls.htm || die

	if [[ ${CHOST} == *-darwin* ]] ; then
		# this is ugly, but fixing the makefile mess is even worse
		local loc=usr/$(get_libdir)/tls1.6/libtls1.6.dylib
		install_name_tool -id "${EPREFIX}"/${loc} "${ED}"/${loc} || die
	fi
}
