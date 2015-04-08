# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.12.5-r1.ebuild,v 1.6 2015/04/08 07:30:34 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils python-any-r1

DESCRIPTION="SPICE server and client"
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="client sasl smartcard static-libs" # static

# only the client links against libcacard, the libspice-server only uses the headers
# the client cannot be built statically since alsa and qemu[smartcard] are missing static-libs
RDEPEND=">=x11-libs/pixman-0.17.7[static-libs(+)?]
	>=dev-libs/glib-2.22:2[static-libs(+)?]
	>=media-libs/celt-0.5.1.1:0.5.1[static-libs(+)?]
	media-libs/opus[static-libs(+)?]
	dev-libs/openssl[static-libs(+)?]
	virtual/jpeg[static-libs(+)?]
	sys-libs/zlib[static-libs(+)?]
	sasl? ( dev-libs/cyrus-sasl[static-libs(+)?] )
	client? (
		media-libs/alsa-lib
		>=x11-libs/libXrandr-1.2
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/libXinerama-1.0
		x11-libs/libXfixes
		x11-libs/libXrender
		smartcard? ( app-emulation/qemu[smartcard] )
	)"

DEPEND="virtual/pkgconfig
	$(python_gen_any_dep \
		'>=dev-python/pyparsing-1.5.6-r2[${PYTHON_USEDEP}]')
	smartcard? ( app-emulation/qemu[smartcard] )
	${RDEPEND}"

python_check_deps() {
	has_version ">=dev-python/pyparsing-1.5.6-r2[${PYTHON_USEDEP}]"
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && python-any-r1_pkg_setup
}

# maintainer notes:
# * opengl support is currently broken

src_prepare() {
	epatch \
		"${FILESDIR}/0.11.0-gold.patch" \
		"${FILESDIR}/${P}-fix-assert-in-mjpeg_encoder_adjust_params_to_bit_rate.patch" \
		"${FILESDIR}/${P}-server-dont-assert-on-invalid-client-message.patch" \
		"${FILESDIR}/${P}-fix-crash-when-clearing-surface-memory.patch"

	epatch_user
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable client) \
		$(use_with sasl) \
		$(use_enable smartcard) \
		--disable-gui \
		--disable-static-linkage
#		$(use_enable static static-linkage) \
}

src_install() {
	default
	use static-libs || prune_libtool_files
}
