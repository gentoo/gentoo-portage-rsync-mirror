# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libpaper/libpaper-1.1.24-r1.ebuild,v 1.9 2012/04/26 20:47:07 aballier Exp $

EAPI=4

inherit eutils autotools

MY_PV=${PV/_p/+nmu}
DESCRIPTION="Library for handling paper characteristics"
HOMEPAGE="http://packages.debian.org/unstable/source/libpaper"
SRC_URI="mirror://debian/pool/main/libp/libpaper/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS=( README ChangeLog debian/changelog )

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-static
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +

	dodir /etc
	(paperconf 2>/dev/null || echo a4) > "${ED}"/etc/papersize \
		|| die "papersize config failed"
}

pkg_postinst() {
	echo
	elog "run \"paperconf -p letter\" as root to use letter-pagesizes"
	elog "or paperconf with normal user privileges."
	echo
}
