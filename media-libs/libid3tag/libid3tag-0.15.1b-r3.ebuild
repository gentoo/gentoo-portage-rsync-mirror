# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libid3tag/libid3tag-0.15.1b-r3.ebuild,v 1.1 2013/07/21 21:37:15 ottxor Exp $

EAPI=5
inherit eutils multilib libtool

DESCRIPTION="The MAD id3tag library"
HOMEPAGE="http://www.underbit.com/products/mad/"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="debug static-libs"

RDEPEND=">=sys-libs/zlib-1.1.3"
DEPEND="${RDEPEND}
	dev-util/gperf"

src_prepare() {
	epunt_cxx #74489
	epatch "${FILESDIR}/${PV}"/*.patch
	elibtoolize #sane .so versionning on fbsd and .so -> .so.version symlink
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug debugging)
}

src_install() {
	default

	# This file must be updated with every version update
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${FILESDIR}"/id3tag.pc
	sed -i \
		-e "s:prefix=.*:prefix=${EPREFIX}/usr:" \
		-e "s:libdir=\${exec_prefix}/lib:libdir=${EPREFIX}/usr/$(get_libdir):" \
		-e "s:0.15.0b:${PV}:" \
		"${ED}"/usr/$(get_libdir)/pkgconfig/id3tag.pc || die

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
