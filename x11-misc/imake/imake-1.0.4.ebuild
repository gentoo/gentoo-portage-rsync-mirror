# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/imake/imake-1.0.4.ebuild,v 1.9 2011/10/23 19:24:31 grobian Exp $

EAPI=3

XORG_STATIC=no
inherit xorg-2

DESCRIPTION="C preprocessor interface to the make utility"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="x11-misc/xorg-cf-files"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	# don't use Sun compilers on Solaris, we want GCC from prefix
	sed -i \
		-e "1s/^/#if defined(sun)\n# undef sun\n#endif/" \
		imake.c imakemdep.h || die "sed failed"
	xorg-2_src_prepare
}
