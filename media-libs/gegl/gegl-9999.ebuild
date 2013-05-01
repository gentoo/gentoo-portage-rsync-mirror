# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gegl/gegl-9999.ebuild,v 1.7 2013/05/01 00:46:15 sping Exp $

EAPI=4

VALA_MIN_API_VERSION=0.14
VALA_USE_DEPEND=vapigen

inherit vala gnome2-utils eutils autotools git-2

DESCRIPTION="A graph based image processing framework"
HOMEPAGE="http://www.gegl.org/"
EGIT_REPO_URI="git://git.gnome.org/${PN}"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS=""

IUSE="cairo debug ffmpeg introspection jpeg jpeg2k lensfun mmx openexr png raw sdl sse svg umfpack vala"

RDEPEND=">=media-libs/babl-0.1.10[introspection?]
	>=dev-libs/glib-2.28:2
	>=x11-libs/gdk-pixbuf-2.18:2
	x11-libs/pango
	sys-libs/zlib
	cairo? ( x11-libs/cairo )
	ffmpeg? ( virtual/ffmpeg )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( >=media-libs/jasper-1.900.1 )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng )
	raw? ( >=media-libs/libopenraw-0.0.5 )
	sdl? ( media-libs/libsdl )
	svg? ( >=gnome-base/librsvg-2.14:2 )
	umfpack? ( sci-libs/umfpack )
	introspection? ( >=dev-libs/gobject-introspection-0.10
			>=dev-python/pygobject-2.26:2 )
	lensfun? ( >=media-libs/lensfun-0.2.5 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.1
	dev-lang/perl
	virtual/pkgconfig
	>=sys-devel/libtool-2.2
	vala? ( $(vala_depend) )"

DOCS=( ChangeLog NEWS )

src_prepare() {
	# fix OSX loadable module filename extension
	sed -i -e 's/\.dylib/.bundle/' configure.ac || die
	# don't require Apple's OpenCL on versions of OSX that don't have it
	if [[ ${CHOST} == *-darwin* && ${CHOST#*-darwin} -le 9 ]] ; then
		sed -i -e 's/#ifdef __APPLE__/#if 0/' gegl/opencl/* || die
	fi
	eautoreconf

	use vala && vala_src_prepare
}

src_configure() {
	# never enable altering of CFLAGS via profile option
	# libspiro: not in portage main tree
	# disable documentation as the generating is bit automagic
	#    if anyone wants to work on it just create bug with patch

	# Also please note that:
	#
	#  - Some auto-detections are not patched away since the docs are
	#    not built (--disable-docs, lack of --enable-gtk-doc) and these
	#    tools affect re-generation of docs, only
	#    (e.g. ruby, asciidoc, dot (of graphviz), enscript)
	#
	#  - Parameter --with-exiv2 compiles a noinst-app only, no use
	#
	#  - Parameter --disable-workshop disables any use of Lua, effectivly
	# 
	#  - v4l support does not work with our media-libs/libv4l-0.8.9,
	#    upstream bug https://bugzilla.gnome.org/show_bug.cgi?id=654675
	#
	#  - There are two checks for dot, one controlled by --with(out)-graphviz
	#    which toggles HAVE_GRAPHVIZ that is not used anywhere.  Yes.
	#
	# So that's why USE="exif graphviz lua v4l" got resolved.  More at:
	# https://bugs.gentoo.org/show_bug.cgi?id=451136
	#
	econf \
		--disable-silent-rules \
		--disable-profile \
		--without-libspiro \
		--disable-docs --disable-workshop \
		--with-pango --with-gdk-pixbuf \
		$(use_enable mmx) \
		$(use_enable sse) \
		$(use_enable debug) \
		$(use_with cairo) \
		$(use_with cairo pangocairo) \
		--without-exiv2 \
		$(use_with ffmpeg libavformat) \
		--without-graphviz \
		$(use_with jpeg libjpeg) \
		$(use_with jpeg2k jasper) \
		--without-lua \
		$(use_with openexr) \
		$(use_with png libpng) \
		$(use_with raw libopenraw) \
		$(use_with sdl) \
		$(use_with svg librsvg) \
		$(use_with umfpack) \
		--without-libv4l \
		$(use_enable introspection) \
		$(use_with lensfun) \
		$(use_with vala)
}

src_test() {
	gnome2_environment_reset  # sandbox issues
	default
}

src_compile() {
	gnome2_environment_reset  # sandbox issues (bug #396687)
	default

	emake ./ChangeLog  # "./" prevents "Circular ChangeLog <- ChangeLog dependency dropped."
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
