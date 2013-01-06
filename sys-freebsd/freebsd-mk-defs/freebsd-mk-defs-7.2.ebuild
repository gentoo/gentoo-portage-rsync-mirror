# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-mk-defs/freebsd-mk-defs-7.2.ebuild,v 1.1 2009/05/22 13:37:30 aballier Exp $

inherit bsdmk freebsd

DESCRIPTION="Makefiles definitions used for building and installing libraries and system files"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc-fbsd ~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${SHARE}.tar.bz2"

RDEPEND=""
DEPEND=""

RESTRICT="strip"

S="${WORKDIR}/share/mk"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${PN}-7.1-gentoo.patch"

	[[ ${CHOST} != *-*bsd* || ${CHOST} == *-gnu ]] && \
		epatch "${FILESDIR}/${PN}-7.1-gnu.patch"
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
