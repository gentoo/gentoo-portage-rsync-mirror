# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconf/pkgconf-0.9.2.ebuild,v 1.11 2013/05/27 16:40:22 bicatali Exp $

EAPI="4"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/pkgconf/pkgconf.git"
	inherit autotools git-2
else
	inherit eutils
	SRC_URI="http://tortois.es/~nenolod/distfiles/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~amd64-linux ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc64-solaris"
fi

DESCRIPTION="pkg-config compatible replacement with no dependencies other than ANSI C89"
HOMEPAGE="https://github.com/pkgconf/pkgconf"

LICENSE="BSD-1"
SLOT="0"
IUSE="+pkg-config strict"

DEPEND=""
RDEPEND="${DEPEND}
	pkg-config? (
		!dev-util/pkgconfig
		!dev-util/pkg-config-lite
		!dev-util/pkgconfig-openbsd[pkg-config]
	)"

src_prepare() {
	[[ -e configure ]] || eautoreconf
}

src_configure() {
	econf $(use_enable strict)
}

src_install() {
	default
	use pkg-config \
		&& dosym pkgconf /usr/bin/pkg-config \
		|| rm "${ED}"/usr/share/aclocal/pkg.m4 \
		|| die
}
