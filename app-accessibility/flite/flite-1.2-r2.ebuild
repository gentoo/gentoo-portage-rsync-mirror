# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.2-r2.ebuild,v 1.4 2014/08/02 11:19:45 armin76 Exp $

EAPI=5
inherit eutils

DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/${P}/${P}-release.tar.bz2
	 http://www.speech.cs.cmu.edu/flite/packed/${P}/${PN}_lexfix.tar.gz"

LICENSE="BSD freetts public-domain regexp-UofT BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc ~x86"
IUSE="static"

S=${WORKDIR}/${P}-release

src_unpack() {
	unpack ${P}-release.tar.bz2
	unpack ${PN}_lexfix.tar.gz

	# Move the update into ${S}
	cd ${PN}
	tar -cf - . | (cd "${S}"; tar -xf -)
}

src_prepare() {
	epatch "${FILESDIR}"/const.patch
	epatch "${FILESDIR}"/${P}-tempfile.patch
}

src_configure() {
	local myconf
	if ! use static ; then
		myconf="${myconf} --enable-shared"
	fi
	myconf="${myconf} --with-vox=cmu_us_kal16"

	econf ${myconf}
	# -j2 borks when we make the shared libs
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
