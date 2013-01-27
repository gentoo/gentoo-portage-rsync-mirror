# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-mk-defs/freebsd-mk-defs-9.1.ebuild,v 1.1 2013/01/27 21:26:05 aballier Exp $

EAPI=3

inherit bsdmk freebsd

DESCRIPTION="Makefiles definitions used for building and installing libraries and system files"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"

IUSE="userland_GNU"

SRC_URI="mirror://gentoo/${SHARE}.tar.bz2"

RDEPEND=""
DEPEND=""

RESTRICT="strip"

S="${WORKDIR}/share/mk"

src_prepare() {
	epatch "${FILESDIR}/${PN}-9.1-gentoo.patch"
	use userland_GNU && epatch "${FILESDIR}/${PN}-9.1-gnu.patch"
}

src_compile() { :; }

src_install() {
	if [[ ${CHOST} != *-freebsd* ]]; then
		insinto /usr/share/mk/freebsd
	else
		insinto /usr/share/mk
	fi
	doins *.mk *.awk
}
