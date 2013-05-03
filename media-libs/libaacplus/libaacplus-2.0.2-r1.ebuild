# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaacplus/libaacplus-2.0.2-r1.ebuild,v 1.1 2013/05/03 13:37:17 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

# This file cannot be mirrored.
# See the notes at http://tipok.org.ua/node/17
# The .tar.gz, ie the wrapper library, is lgpl though.
TGPPDIST=26410-800.zip

DESCRIPTION="HE-AAC+ v2 library, based on the reference implementation"
HOMEPAGE="http://tipok.org.ua/node/17"
SRC_URI="
	http://dev.gentoo.org/~aballier/${P}.tar.gz
	http://tipok.ath.cx/downloads/media/aac+/libaacplus/${P}.tar.gz
	http://217.20.164.161/~tipok/aacplus/${P}.tar.gz
	http://www.3gpp.org/ftp/Specs/archive/26_series/26.410/${TGPPDIST}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="bindist fftw static-libs"

RESTRICT="mirror"
REQUIRED_USE="!bindist"

RDEPEND="
	!media-sound/aacplusenc
	fftw? ( sci-libs/fftw:3.0 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	sed \
		-e 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' \
		-i configure.ac || die
	autotools-utils_src_prepare
	cp "${DISTDIR}/${TGPPDIST}" src/ || die
}

src_configure() {
	local myeconfargs=( $(use_with fftw fftw3) )
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile -j1
}
