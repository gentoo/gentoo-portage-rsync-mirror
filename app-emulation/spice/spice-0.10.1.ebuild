# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.10.1.ebuild,v 1.5 2012/06/07 15:36:01 jlec Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+client +gui sasl smartcard static static-libs"

RDEPEND=">=app-emulation/spice-protocol-0.10.1
	>=x11-libs/pixman-0.17.7
	media-libs/alsa-lib
	media-libs/celt:0.5.1
	dev-libs/openssl
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXfixes
	x11-libs/libXrender
	virtual/jpeg
	sys-libs/zlib
	client? ( gui? ( =dev-games/cegui-0.6* ) )
	sasl? ( dev-libs/cyrus-sasl )
	smartcard? ( >=app-emulation/libcacard-0.1.2 )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

# maintainer notes:
# * opengl support is currently broken
# * TODO: add slirp for tunnel-support

src_prepare() {
	epatch \
		"${FILESDIR}/0.10.1-disable-werror.patch" \
		"${FILESDIR}/${PV}-gold.patch"
	eautoreconf
}

src_configure() {
	local gui="$(use_enable gui)"
	use client || gui="--disable-gui"
	econf \
		$(use_enable static-libs static) \
		--disable-tunnel \
		${gui} \
		$(use_enable client) \
		$(use_enable static static-linkage) \
		$(use_with sasl) \
		$(use_enable smartcard)
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/lib*/*.la
}
