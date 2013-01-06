# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.8.2-r1.ebuild,v 1.2 2012/05/03 18:49:07 jdhore Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui sasl static-libs"

RDEPEND=">=app-emulation/spice-protocol-0.8.1
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
	gui? ( =dev-games/cegui-0.6* )
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

# maintainer notes:
# * opengl support is currently broken
# * add slirp for tunnel-support
# * add libcacard for smartcard support

src_prepare() {
	epatch "${FILESDIR}/54c660470a5aea19f799c5574cc0d4a707696712.patch"
	eautoreconf
}

src_configure() {
	local myconf=""
	use gui && myconf+="--enable-gui "
	econf ${myconf} \
		$(use_enable static-libs static) \
		$(use_with sasl)
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/lib*/*.la
}
