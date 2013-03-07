# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.3.6.ebuild,v 1.2 2013/03/07 19:57:50 radhermit Exp $

EAPI=5

inherit autotools eutils gnome.org

DESCRIPTION="An elegant API for accessing audio files"
HOMEPAGE="http://www.68k.org/~michael/audiofile/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/1" # subslot = soname major version
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="flac static-libs test"

RDEPEND="flac? ( >=media-libs/flac-1.2.1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-cpp/gtest )"

DOCS=( ACKNOWLEDGEMENTS AUTHORS ChangeLog NEWS NOTES README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${P}-system-gtest.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-largefile \
		--disable-werror \
		--disable-examples \
		$(use_enable flac)
}

src_test() {
	emake -C test check
}

src_install() {
	default
	prune_libtool_files
}
