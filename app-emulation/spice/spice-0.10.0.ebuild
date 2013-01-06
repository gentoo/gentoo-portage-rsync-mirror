# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.10.0.ebuild,v 1.5 2012/09/23 08:31:54 phajdan.jr Exp $

EAPI=4

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+client +gui sasl static static-libs"

RDEPEND=">=app-emulation/spice-protocol-0.10.0
	>=x11-libs/pixman-0.17.7
	media-libs/alsa-lib
	media-libs/celt:0.5.1
	dev-libs/openssl
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXfixes
	virtual/jpeg
	sys-libs/zlib
	client? ( gui? ( =dev-games/cegui-0.6* ) )
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

# maintainer notes:
# * opengl support is currently broken
# * add slirp for tunnel-support
# * add libcacard for smartcard support

src_configure() {
	local gui="$(use_enable gui)"
	use client || gui="--disable-gui"
	econf \
		$(use_enable static-libs static) \
		--disable-tunnel \
		${gui} \
		--disable-smartcard \
		$(use_enable client) \
		$(use_enable static static-linkage) \
		$(use_with sasl)
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/lib*/*.la
}
