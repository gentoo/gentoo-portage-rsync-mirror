# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/frei0r-plugins/frei0r-plugins-1.1.22-r1.ebuild,v 1.9 2011/08/10 16:53:33 xarthisius Exp $

EAPI="2"
inherit base eutils autotools multilib

DESCRIPTION="A minimalistic plugin API for video effects"
HOMEPAGE="http://www.piksel.org/frei0r/"
SRC_URI="http://propirate.net/frei0r/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86 ~x86-fbsd"
IUSE="doc facedetect scale0tilt"

DEPEND="facedetect? ( media-libs/opencv )
	scale0tilt? ( media-libs/gavl )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-automagic-deps.patch
	epatch "${FILESDIR}"/${P}-libdir.patch
	epatch "${FILESDIR}"/${P}-pkgconfig-support.patch   # needed by media-libs/mlt
	eautoreconf
}

src_configure() {
	econf $(use_enable facedetect) \
		$(use_enable scale0tilt) \
		--libdir=/usr/$(get_libdir)
}

src_install() {
	base_src_install
	dodoc AUTHORS README
	use doc && dohtml -r doc/html
}
