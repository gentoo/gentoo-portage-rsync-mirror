# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.2.1.201012301333-r1.ebuild,v 1.4 2012/12/11 16:27:09 ssuominen Exp $

EAPI=2

inherit flag-o-matic toolchain-funcs versionator eutils

MY_PV="$(replace_version_separator 3 -)"

DESCRIPTION="Administrative interface for the grsecurity Role Based Access Control system"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="pam"

CDEPEND="virtual/udev"
RDEPEND="${CDEPEND}"
DEPEND="
	${CDEPEND}
	sys-devel/bison
	sys-devel/flex
	pam? ( virtual/pam )
	sys-apps/paxctl"

S="${WORKDIR}/${PN}2"

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
}

src_compile() {
	local target
	use pam || target="nopam"

	emake ${target} CC="$(tc-getCC)" OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	einstall DESTDIR="${D}" || die "einstall failed"
	fperms 711 /sbin/gradm
}

pkg_postinst() {
	udevadm control --reload-rules && udevadm trigger --action=add --sysname-match=grsec
	einfo
	ewarn
	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
	ewarn "This version of gradm is only supported with hardened-sources >= 2.6.32-r10"
	ewarn
	einfo
}
