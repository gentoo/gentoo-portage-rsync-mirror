# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.2.0_beta2-r5.ebuild,v 1.1 2012/02/09 18:27:38 slyfox Exp $

EAPI=2
MY_P=${P/_/-}
inherit autotools eutils flag-o-matic

DESCRIPTION="A library to play a wide range of module formats"
HOMEPAGE="http://mikmod.raphnet.net/"
SRC_URI="http://mikmod.raphnet.net/files/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 LGPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
# Enable OSS by default since ALSA support isn't available, look below
IUSE="+oss raw static-libs"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-64bit.patch \
		"${FILESDIR}"/${P}-autotools.patch \
		"${FILESDIR}"/${P}-info.patch \
		"${FILESDIR}"/${P}-doubleRegister.patch \
		"${FILESDIR}"/${PN}-CVE-2007-6720.patch \
		"${FILESDIR}"/${PN}-CVE-2009-0179.patch \
		"${FILESDIR}"/${P}-no-drv_raw.patch \
		"${FILESDIR}"/${P}-fix-vol-crash.patch \
		"${FILESDIR}"/${P}-fix-unload-crash.patch \
		"${FILESDIR}"/${P}-CVE-2009-3995-3996.patch \
		"${FILESDIR}"/${P}-CVE-2010-2546-2971.patch \
		"${FILESDIR}"/${P}-pa-workaround.patch \
		"${FILESDIR}"/${P}-shell.patch

	AT_M4DIR=${S} eautoreconf
}

src_configure() {
	use raw && append-flags -DDRV_RAW

	# * af is something called AF/AFlib.h and -lAF, not audiofile in tree
	# * alsa support is for deprecated API and doesn't work
	econf \
		--disable-af \
		--disable-alsa \
		--disable-esd \
		$(use_enable oss) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO
	dohtml docs/*.html

	use static-libs || find "${ED}" -name '*.la' -delete
}

pkg_postinst() {
	use oss || ewarn "No audio output will be available because of USE=\"-oss\"."
}
