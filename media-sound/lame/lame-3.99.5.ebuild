# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.99.5.ebuild,v 1.13 2013/02/21 18:41:59 zmedico Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://lame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-automake-2.12.patch.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="debug mmx mp3rtp sndfile static-libs"

RDEPEND=">=sys-libs/ncurses-5.7-r7
	sndfile? ( >=media-libs/libsndfile-1.0.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	mmx? ( dev-lang/nasm )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.96-ccc.patch \
		"${FILESDIR}"/${PN}-3.98-gtk-path.patch \
		"${WORKDIR}"/${P}-automake-2.12.patch

	mkdir libmp3lame/i386/.libs || die #workaround parallel build with nasm

	sed -i -e '/define sp/s/+/ + /g' libmp3lame/i386/nasm.h || die

	use mmx || sed -i -e '/AC_PATH_PROG/s:nasm:dIsAbLe&:' configure.in #361879

	AT_M4DIR=${S} eautoreconf
	epunt_cxx #74498
}

src_configure() {
	local myconf
	use mmx && myconf+="--enable-nasm" #361879
	use sndfile && myconf+=" --with-fileio=sndfile"

	econf \
		$(use_enable static-libs static) \
		$(use_enable debug debug norm) \
		--disable-mp3x \
		$(use_enable mp3rtp) \
		--enable-dynamic-frontends \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" pkghtmldir="${EPREFIX}/usr/share/doc/${PF}/html" install
	dobin misc/mlame

	dodoc API ChangeLog HACKING README STYLEGUIDE TODO USAGE
	dohtml misc/lameGUI.html Dll/LameDLLInterface.htm

	find "${ED}" -name '*.la' -exec rm -f {} +
}
