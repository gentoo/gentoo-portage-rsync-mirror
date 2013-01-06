# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsepol/libsepol-2.1.4-r1.ebuild,v 1.3 2012/10/03 20:34:13 vapier Exp $

EAPI="4"

inherit multilib toolchain-funcs eutils

DESCRIPTION="SELinux binary policy representation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120216/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# tests are not meant to be run outside of the
# full SELinux userland repo
RESTRICT="test"

src_prepare() {
	# fix up paths for multilib
	sed -i \
		-e "/^LIBDIR/s/lib/$(get_libdir)/" \
		-e "/^SHLIBDIR/s/lib/$(get_libdir)/" \
		-e 's:\<ranlib\>:$(RANLIB):' \
		src/Makefile || die
	epatch "${FILESDIR}/libsepol-2.1.4-fix_role_fix_callback.patch"
	tc-export AR CC RANLIB
}
