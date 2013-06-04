# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.12.3.ebuild,v 1.1 2013/06/04 22:13:36 cardoe Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit eutils python-any-r1

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client gui sasl smartcard static-libs" # static

RDEPEND=">=x11-libs/pixman-0.17.7
	media-libs/alsa-lib
	media-libs/celt:0.5.1
	dev-libs/openssl
	virtual/jpeg
	sys-libs/zlib
	sasl? ( dev-libs/cyrus-sasl )
	smartcard? ( >=app-emulation/libcacard-0.1.2 )
	client? (
		gui? ( =dev-games/cegui-0.6*[opengl] )
		>=x11-libs/libXrandr-1.2
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXinerama
		x11-libs/libXfixes
		x11-libs/libXrender
	)"

# broken as we don't have static alsa-lib and building that one static requires more work
#		static? (
#			>=x11-libs/pixman-0.17.7[static-libs(+)]
#			media-libs/celt:0.5.1[static-libs(+)]
#			virtual/jpeg[static-libs(+)]
#			sys-libs/zlib[static-libs(+)]
#			media-libs/alsa-lib[static-libs(-)]
#			>=x11-libs/libXrandr-1.2[static-libs(+)]
#			x11-libs/libX11[static-libs(+)]
#			x11-libs/libXext[static-libs(+)]
#			x11-libs/libXinerama[static-libs(+)]
#			x11-libs/libXfixes[static-libs(+)]
#			x11-libs/libXrender[static-libs(+)]
#		)
#	)"
DEPEND="virtual/pkgconfig
	virtual/pyparsing
	${RDEPEND}"

pkg_setup() {
	python-any-r1_pkg_setup
	python_export_best
}

# maintainer notes:
# * opengl support is currently broken
# * TODO: add slirp for tunnel-support

src_prepare() {
	epatch \
		"${FILESDIR}/0.11.0-gold.patch"
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-tunnel \
		$(use_enable client) \
		$(use_enable gui) \
		$(use_with sasl) \
		$(use_enable smartcard) \
		--disable-static-linkage
#		$(use_enable static static-linkage) \
}

src_install() {
	default
	use static-libs || rm "${D}"/usr/lib*/*.la
}

pkg_postinst() {
	if use client -o use gui; then
		ewarn "USE=client and USE=gui will be removed in the next version."
		ewarn "Upstream has stated that 'spicy' is deprecated and that you"
		ewarn "should use 'remote-viewer' from app-emulation/virt-viewer."
	fi
}
