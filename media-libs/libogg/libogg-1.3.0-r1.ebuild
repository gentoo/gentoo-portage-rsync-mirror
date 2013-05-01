# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.3.0-r1.ebuild,v 1.4 2013/05/01 21:30:07 mgorny Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-multilib

DESCRIPTION="the Ogg media file format library"
HOMEPAGE="http://xiph.org/ogg/"
SRC_URI="http://downloads.xiph.org/releases/ogg/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND="
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20121202 )"

AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
DOCS=( AUTHORS CHANGES )

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/ogg/config_types.h
)

src_prepare() {
	# Fix automake-1.13 compat, copied from libvorbis.
	sed -i \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' \
		configure.in || die

	# Un-hack docdir redefinition.
	# https://trac.xiph.org/ticket/1758
	find -name 'Makefile.am' \
		-exec sed -i \
			-e 's:$(datadir)/doc/$(PACKAGE)-$(VERSION):@docdir@/html:' \
			{} + || die

	autotools-multilib_src_prepare
}
