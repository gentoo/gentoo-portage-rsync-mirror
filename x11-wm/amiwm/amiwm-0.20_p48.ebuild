# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/amiwm/amiwm-0.20_p48.ebuild,v 1.11 2010/05/29 13:10:44 xarthisius Exp $

EAPI="2"

inherit eutils multilib toolchain-funcs

MY_P="${PN}${PV/_p/pl}"
DESCRIPTION="Windowmanager ala Amiga(R) Workbench(R)"
HOMEPAGE="http://www.lysator.liu.se/~marcus/amiwm.html"
SRC_URI="ftp://ftp.lysator.liu.se/pub/X11/wm/amiwm/${MY_P}.tar.gz"

LICENSE="amiwm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext"

RDEPEND="${COMMON_DEPEND}
	media-gfx/xloadimage
	x11-apps/xrdb
	x11-apps/xsetroot
	x11-terms/xterm"
DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-flex.patch \
		"${FILESDIR}"/${P}-gentoo.diff
	sed -i -e "s:\$(exec_prefix)/lib:\$(exec_prefix)/$(get_libdir):" \
		Makefile.in || die
	sed -i -e "s:/bin/ksh:/bin/sh:g" Xsession{,2}.in || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc README* || die

	exeinto /etc/X11/Sessions
	cat <<- EOF > "${T}"/amiwm
		#!/bin/sh
		exec /usr/bin/amiwm
	EOF
	doexe "${T}"/amiwm
}
