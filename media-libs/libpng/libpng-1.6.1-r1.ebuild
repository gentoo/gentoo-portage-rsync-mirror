# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.6.1-r1.ebuild,v 1.1 2013/04/14 09:28:28 ssuominen Exp $

EAPI=5

inherit eutils libtool multilib

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz
	apng? ( mirror://sourceforge/apng/${P}-apng.patch.gz )"

LICENSE="libpng"
SLOT="0/16"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="apng neon static-libs"

RDEPEND="sys-libs/zlib:="
DEPEND="${RDEPEND}
	app-arch/xz-utils"

DOCS=( ANNOUNCE CHANGES libpng-manual.txt README TODO )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-Corrected-length-written-to-uncompressed-iT.patch \
		"${FILESDIR}"/${P}-Fixed-previous-bugfix-to-work-on-64-bit-pla.patch \
		"${FILESDIR}"/${P}-Removed-extra-recently-inserted-line-from-p.patch

	if use apng; then
		epatch "${WORKDIR}"/${PN}-*-apng.patch
		# Don't execute symbols check with apng patch wrt #378111
		sed -i -e '/^check/s:scripts/symbols.chk::' Makefile.in || die
	fi
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-arm-neon=$(usex neon on off)
}

src_install() {
	default
	# Even prune_libtool --all fails to remove libpng.la dead symlink wrt #436996
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_preinst() {
	has_version ${CATEGORY}/${PN}:1.5 && return 0
	preserve_old_lib /usr/$(get_libdir)/libpng15$(get_libname 15)
}

pkg_postinst() {
	has_version ${CATEGORY}/${PN}:1.5 && return 0
	preserve_old_lib_notify /usr/$(get_libdir)/libpng15$(get_libname 15)
}
