# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/atop/atop-2.0.2.ebuild,v 1.2 2013/08/07 17:22:35 bicatali Exp $

EAPI="4"

inherit eutils toolchain-funcs

MY_PV=${PV//_p/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Resource-specific view of processes"
HOMEPAGE="http://www.atoptool.nl/"
SRC_URI="http://www.atoptool.nl/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="sys-process/acct"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.2-build.patch
	tc-export CC
	cp "${FILESDIR}"/atop.rc atop.init
	chmod a+rx atop.init
	sed -i 's: root : :' atop.cron #191926
	# prefixify
	sed -i "s:/\(usr\|etc\|var\):${EPREFIX}/\1:g" Makefile
}

src_install() {
	default
	# useless -${PV} copies ?
	rm -f "${ED}"/usr/bin/atop*-${PV}
	dodoc "${ED}"/etc/cron.d/*
	rm -r "${ED}"/etc/cron.d || die
}
