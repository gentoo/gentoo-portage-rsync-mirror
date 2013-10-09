# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice/spice-0.12.4.ebuild,v 1.5 2013/10/09 05:24:36 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit eutils python-any-r1

DESCRIPTION="SPICE server and client."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client sasl smartcard static-libs" # static

RDEPEND=">=x11-libs/pixman-0.17.7
	>=dev-libs/glib-2.22:2
	media-libs/alsa-lib
	>=media-libs/celt-0.5.1.1:0.5.1
	dev-libs/openssl
	virtual/jpeg
	sys-libs/zlib
	sasl? ( dev-libs/cyrus-sasl )
	smartcard? ( >=app-emulation/libcacard-0.1.2 )
	client? (
		>=x11-libs/libXrandr-1.2
		x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/libXinerama-1.0
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
	$(python_gen_any_dep \
		'>=dev-python/pyparsing-1.5.6-r2[${PYTHON_USEDEP}]')
	${RDEPEND}"

python_check_deps() {
	has_version ">=dev-python/pyparsing-1.5.6-r2[${PYTHON_USEDEP}]"
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && python-any-r1_pkg_setup
}

# maintainer notes:
# * opengl support is currently broken
# * TODO: add slirp for tunnel-support

src_prepare() {
	epatch \
		"${FILESDIR}/0.11.0-gold.patch"

	epatch_user
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-tunnel \
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
