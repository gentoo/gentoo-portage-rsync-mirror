# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.06-r2.ebuild,v 1.1 2013/04/04 13:46:28 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils toolchain-funcs

DESCRIPTION="Password Generator"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"
SRC_URI="mirror://sourceforge/pwgen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="livecd"

PATCHES=( "${FILESDIR}"/${PV}-special-char.patch )

src_prepare() {
	sed -i -e 's:$(prefix)/man/man1:$(mandir)/man1:g' Makefile.in || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=( --sysconfdir="${EPREFIX}"/etc/pwgen )
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	use livecd && newinitd "${FILESDIR}"/pwgen.rc pwgen
}
