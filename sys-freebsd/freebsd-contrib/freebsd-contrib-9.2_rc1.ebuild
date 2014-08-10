# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-contrib/freebsd-contrib-9.2_rc1.ebuild,v 1.3 2014/08/10 20:19:23 slyfox Exp $

inherit bsdmk freebsd flag-o-matic multilib

DESCRIPTION="Contributed sources for FreeBSD"
if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
	SRC_URI="mirror://gentoo/${GNU}.tar.bz2
		mirror://gentoo/${P}.tar.bz2"
fi
LICENSE="BSD GPL-2+ libodialog"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/gnu"

src_compile() {
	cd "${S}/lib/libodialog"
	freebsd_src_compile

	cd "${S}/usr.bin/sort"
	freebsd_src_compile

	cd "${S}/usr.bin/patch"
	freebsd_src_compile
}

src_install() {
	use profile || mymakeopts="${mymakeopts} NO_PROFILE= "
	mymakeopts="${mymakeopts} NO_MANCOMPRESS= NO_INFOCOMPRESS= "

	cd "${S}/lib/libodialog"
	mkinstall LIBDIR="/usr/$(get_libdir)" || die "libodialog install failed"

	cd "${S}/usr.bin/sort"
	mkinstall BINDIR="/bin/" || die "sort install failed"

	cd "${S}/usr.bin/patch"
	mkinstall BINDIR="/usr/bin/" || die "patch install failed"
}
