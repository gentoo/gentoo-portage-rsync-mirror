# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.10.2-r3.ebuild,v 1.15 2014/07/26 08:57:55 ssuominen Exp $

EAPI=3

EGIT_REPO_URI="git://anongit.freedesktop.org/git/cairo"
[[ ${PV} == *9999 ]] && GIT_ECLASS="git"

inherit eutils flag-o-matic autotools ${GIT_ECLASS}

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
[[ ${PV} == *9999 ]] || SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="X aqua debug directfb doc drm gallium +glib opengl openvg qt4 static-libs +svg xcb"

# Test causes a circular depend on gtk+... since gtk+ needs cairo but test needs gtk+ so we need to block it
RESTRICT="test"

RDEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libpng:0
	sys-libs/zlib
	>=x11-libs/pixman-0.18.4
	directfb? ( dev-libs/DirectFB )
	glib? ( dev-libs/glib:2 )
	opengl? ( || ( media-libs/mesa[egl] media-libs/opengl-apple ) )
	openvg? ( media-libs/mesa[gallium] )
	qt4? ( >=dev-qt/qtgui-4.8:4 )
	X? (
		>=x11-libs/libXrender-0.6
		x11-libs/libX11
		drm? (
			virtual/libudev
			gallium? ( media-libs/mesa[gallium] )
		)
	)
	xcb? (
		x11-libs/libxcb
		x11-libs/xcb-util
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/libtool-2
	doc? (
		>=dev-util/gtk-doc-1.6
		~app-text/docbook-xml-dtd-4.2
	)
	X? (
		x11-proto/renderproto
		drm? (
			x11-proto/xproto
			>=x11-proto/xextproto-7.1
		)
	)"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.8.8-interix.patch
	epatch "${FILESDIR}"/${PN}-1.10.0-buggy_gradients.patch
	epatch "${FILESDIR}"/${P}-interix.patch
	epatch "${FILESDIR}"/${P}-qt-surface.patch
	epatch "${FILESDIR}"/${P}-export-symbols.patch
	epatch "${FILESDIR}"/${P}-ubuntu.patch
	epatch "${FILESDIR}"/${PN}-respect-fontconfig.patch
	epatch_user

	# Slightly messed build system YAY
	if [[ ${PV} == *9999* ]]; then
		touch boilerplate/Makefile.am.features
		touch src/Makefile.am.features
		touch ChangeLog
	fi

	# We need to run elibtoolize to ensure correct so versioning on FreeBSD
	# upgraded to an eautoreconf for the above interix patch.
	eautoreconf
}

src_configure() {
	local myopts

	# SuperH doesn't have native atomics yet
	use sh && myopts+=" --disable-atomic"

	[[ ${CHOST} == *-interix* ]] && append-flags -D_REENTRANT

	# tracing fails to compile, because Solaris' libelf doesn't do large files
	[[ ${CHOST} == *-solaris* ]] && myopts+=" --disable-trace"

	# 128-bits long arithemetic functions are missing
	[[ ${CHOST} == powerpc*-*-darwin* ]] && filter-flags -mcpu=*

	#gets rid of fbmmx.c inlining warnings
	append-flags -finline-limit=1200

	if use X; then
		myopts+="
			--enable-tee=yes
			$(use_enable drm)
		"

		if use drm; then
			myopts+="
				$(use_enable gallium)
				$(use_enable xcb xcb-drm)
			"
		else
			use gallium && ewarn "Gallium use requires drm use enabled. So disabling for now."
			myopts+="
				--disable-gallium
				--disable-xcb-drm
			"
		fi
	else
		use drm && ewarn "drm use requires X use enabled. So disabling for now."
		myopts+="
			--disable-drm
			--disable-gallium
			--disable-xcb-drm
		"
	fi

	use elibc_FreeBSD && myopts+=" --disable-symbol-lookup"

	# --disable-xcb-lib:
	#	do not override good xlib backed by hardforcing rendering over xcb
	econf \
		--disable-dependency-tracking \
		$(use_with X x) \
		$(use_enable X xlib) \
		$(use_enable X xlib-xrender) \
		$(use_enable aqua quartz) \
		$(use_enable aqua quartz-image) \
		$(use_enable debug test-surfaces) \
		$(use_enable directfb) \
		$(use_enable glib gobject) \
		$(use_enable doc gtk-doc) \
		$(use_enable openvg vg) \
		$(use_enable opengl gl) \
		$(use_enable qt4 qt) \
		$(use_enable static-libs static) \
		$(use_enable svg) \
		$(use_enable xcb) \
		$(use_enable xcb xcb-shm) \
		--enable-ft \
		--enable-pdf \
		--enable-png \
		--enable-ps \
		--disable-xlib-xcb \
		${myopts}
}

src_install() {
	# parallel make install fails
	emake -j1 DESTDIR="${D}" install || die
	find "${ED}" -name '*.la' -exec rm -f {} +
	dodoc AUTHORS ChangeLog NEWS README || die
}
