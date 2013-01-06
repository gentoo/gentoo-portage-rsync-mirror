# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_skey/pam_skey-1.1.5-r3.ebuild,v 1.3 2012/03/24 16:55:05 phajdan.jr Exp $

EAPI=4

inherit eutils pam autotools multilib

DESCRIPTION="PAM interface for the S/Key authentication system"
HOMEPAGE="http://freshmeat.net/projects/pam_skey/"
SRC_URI="http://dkorunic.net/tarballs/${P}.tar.gz
	mirror://gentoo/${P}-patches-4.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=sys-libs/pam-0.78-r3
	>=sys-auth/skey-1.1.5-r4"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

DOCS="README INSTALL"

src_prepare() {
	EPATCH_SUFFIX=patch epatch

	cd autoconf
	eautoconf
	eautoheader
	mv configure defs.h.in .. || die "mv failed"
}

src_configure() {
	econf --libdir="/$(get_libdir)" CFLAGS="${CFLAGS} -fPIC"
}

pkg_postinst() {
	elog "To use this, you need to add a line like:"
	elog
	elog "auth       [success=done ignore=ignore auth_err=die default=bad] pam_skey.so"
	elog
	elog "to an appropriate place in /etc/pam.d/system-auth"
	elog "Consult the documentation for instructions."
}
