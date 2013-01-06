# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg-tools/mpeg-tools-1.5b-r3.ebuild,v 1.6 2011/01/19 21:22:55 spatz Exp $

inherit eutils toolchain-funcs

MY_PN=mpeg_encode
DESCRIPTION="Tools for MPEG video"
HOMEPAGE="http://bmrc.berkeley.edu/research/mpeg/mpeg_encode.html"
SRC_URI="ftp://mm-ftp.cs.berkeley.edu/pub/multimedia/mpeg/encode/${MY_PN}-${PV}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/libX11
	virtual/jpeg"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

src_unpack () {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-64bit_fixes.patch
	epatch "${FILESDIR}"/${P}-tempfile-convert.patch
	cd "${S}"
	rm -r jpeg
	epatch "${FILESDIR}"/${P}-system-jpeg.patch
	epatch "${FILESDIR}"/${P}-system-jpeg-7.patch
	epatch "${FILESDIR}"/${P}-tempfile-mpeg-encode.patch
	epatch "${FILESDIR}"/${P}-tempfile-tests.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
	emake -C convert || die "emake convert failed"
	emake -C convert/mtv || die "emake convert/mtv failed"
}

src_install () {
	dobin mpeg_encode || die "dobin mpeg_encode"
	doman docs/*.1
	dodoc BUGS CHANGES README TODO VERSION
	dodoc docs/EXTENSIONS docs/INPUT.FORMAT docs/*.param docs/param-summary
	docinto examples
	dodoc examples/*

	cd ../convert
	dobin eyuvtojpeg jmovie2jpeg mpeg_demux mtv/movieToVid || die "dobin convert utils"
	newdoc README README.convert
	newdoc mtv/README README.mtv
}

pkg_postinst() {
	if [[ -z $(best_version media-libs/netpbm) ]] ; then
		elog "If you are looking for eyuvtoppm or ppmtoeyuv, please"
		elog "emerge the netpbm package.  It has updated versions."
	fi
}
