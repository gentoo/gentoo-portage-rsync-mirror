# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsamplerate/libsamplerate-0.1.8-r1.ebuild,v 1.1 2013/05/07 12:49:53 mgorny Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
inherit autotools-multilib

DESCRIPTION="Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio"
HOMEPAGE="http://www.mega-nerd.com/SRC/"
SRC_URI="http://www.mega-nerd.com/SRC/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="sndfile static-libs"

RDEPEND="sndfile? ( >=media-libs/libsndfile-1.0.2[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !<=app-emultaion/emul-linux-x86-soundlibs-20130224 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/${PN}-0.1.3-dontbuild-tests-examples.patch"
		"${FILESDIR}/${P}-lm.patch"
	)

	AT_M4DIR="M4" \
	autotools-multilib_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-fftw
		$(use_enable sndfile)
	)
	autotools-multilib_src_configure
}

src_install() {
	autotools-multilib_src_install \
		htmldocdir="${EPREFIX}/usr/share/doc/${PF}/html"
}
