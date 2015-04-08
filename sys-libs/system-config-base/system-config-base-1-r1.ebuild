# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/system-config-base/system-config-base-1-r1.ebuild,v 1.4 2008/03/19 07:28:42 dberkholz Exp $

inherit eutils pam

DESCRIPTION="system-config-* layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/pam"

S=${WORKDIR}

src_unpack() {
	cp "${FILESDIR}"/config-util . || die "failed to copy config-util"
	epatch "${FILESDIR}"/${PVR}-pam-0.99.8.0-r2-compat.patch
}

src_install() {
	dopamd config-util
}

pkg_postinst() {
	if [ "$(stat -c%a ${ROOT}etc/default/useradd)" != "644" ] ; then
		echo
		ewarn
		ewarn "Your ${ROOT}etc/default/useradd file must be world-readable"
		ewarn "for the system-config-* utilities to work properly."
		ewarn "If you did not change them on purpose, consider running:"
		ewarn
		ewarn " chmod 0644 ${ROOT}etc/default/useradd"
		echo
	fi
}
