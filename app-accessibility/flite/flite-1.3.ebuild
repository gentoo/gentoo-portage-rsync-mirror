# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.3.ebuild,v 1.13 2013/06/29 15:37:34 ago Exp $

inherit eutils

DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/${P}/${P}-release.tar.gz"

LICENSE="BSD freetts public-domain regexp-UofT BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm -hppa ppc ppc64 sparc x86"
IUSE="alsa static"

S=${WORKDIR}/${P}-release

src_unpack() {
	unpack ${P}-release.tar.gz
	if use alsa; then
		epatch "${FILESDIR}"/${P}-alsa-support.patch
	fi
	epatch "${FILESDIR}"/${P}-shared-libs.patch
}

src_compile() {
	local myconf
	if ! use static ; then
		myconf="--enable-shared"
	fi
	myconf="${myconf} --with-vox=cmu_us_kal16"

	econf ${myconf} || die "Failed configuration"
	emake -j1 || die "Failed compilation"
}

src_install() {
	dobin bin/* || die
	dodoc ACKNOWLEDGEMENTS README

	if use static ; then
		dolib.a lib/*.a
	else
		for lib in lib/*.so*; do
			if [ -f ${lib} ]; then
				dolib.so ${lib}
				lib=`basename ${lib}`
				majlib=`echo ${lib} | sed 's:\(\.so\.[0-9]\)\(\.[0-9]*\)*$:\1:'`
				noverlib=`echo ${lib} | sed 's:\(\.so\)\(\.[0-9]*\)*$:\1:'`

				dosym ${lib} /usr/lib/${majlib}
				dosym ${lib} /usr/lib/${noverlib}
			fi
		done
	fi

	insinto /usr/include/flite
	cd "${S}"/include
	for file in *.h; do
		doins ${file}
		dosed 's:#include "\(.*\)":#include <flite/\1>:g' /usr/include/flite/${file}
	done

	dosym flite/flite.h /usr/include/flite.h
}
