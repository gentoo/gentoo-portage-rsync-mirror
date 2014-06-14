# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.3-r1.ebuild,v 1.4 2014/06/14 10:28:54 phajdan.jr Exp $

EAPI=5
inherit eutils

DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/${P}/${P}-release.tar.gz"

LICENSE="BSD freetts public-domain regexp-UofT BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ppc ~ppc64 ~sparc x86"
IUSE="alsa static"

S=${WORKDIR}/${P}-release

src_prepare() {
	epatch "${FILESDIR}"/${P}-tempfile.patch
	if use alsa; then
		epatch "${FILESDIR}"/${P}-alsa-support.patch
	fi
	epatch "${FILESDIR}"/${P}-shared-libs.patch
	epatch "${FILESDIR}"/${P}-fix-static.patch
	epatch "${FILESDIR}"/${P}-respect-ldflags.patch
	epatch "${FILESDIR}"/${P}-libm.patch
}

src_configure() {
	local myconf
	if ! use static ; then
		myconf="--enable-shared"
	fi
	myconf="${myconf} --with-vox=cmu_us_kal16"

	econf ${myconf}
}

src_compile() {
	emake -j1
}

src_install() {
	dobin bin/*
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
		sed -i -e 's:#include "\(.*\)":#include <flite/\1>:g' \
			"${D}"/usr/include/flite/${file} || die "sed failed"
	done

	dosym flite/flite.h /usr/include/flite.h
}
