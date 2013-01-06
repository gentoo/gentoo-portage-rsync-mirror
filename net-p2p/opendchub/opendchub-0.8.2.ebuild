# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/opendchub/opendchub-0.8.2.ebuild,v 1.2 2011/08/19 13:59:24 tomka Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="hub software for Direct Connect"
HOMEPAGE="http://opendchub.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="perl"

RDEPEND="perl? ( dev-lang/perl )"
DEPEND="${RDEPEND}"

DOCS="NEWS TODO README AUTHORS Documentation/*"

src_prepare() {
	epatch "${FILESDIR}"/${P}-telnet.patch
	eautoreconf
}

src_configure() {
	! use perl && myconf="--disable-perl --enable-switch_user"
	econf $myconf
}

src_install() {
	default

	if use perl ; then
		exeinto /usr/bin
		doexe "${FILESDIR}"/opendchub_setup.sh
		dodir /usr/share/opendchub/scripts
		insinto /usr/share/opendchub/scripts
		doins Samplescripts/*
	fi
}

pkg_postinst() {
	if use perl ; then
		einfo
		einfo "To set up perl scripts for opendchub to use, please run"
		einfo "opendchub_setup.sh as the user you will be using opendchub as."
		einfo
	fi
}
