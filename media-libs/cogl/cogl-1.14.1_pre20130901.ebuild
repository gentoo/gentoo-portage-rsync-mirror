# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cogl/cogl-1.14.1_pre20130901.ebuild,v 1.2 2013/09/14 09:08:34 pacho Exp $

EAPI="5"
CLUTTER_LA_PUNT="yes"

# Inherit gnome2 after clutter to download sources from gnome.org
inherit eutils clutter gnome2 multilib virtualx

DESCRIPTION="A library for using 3D graphics hardware to draw pretty pictures"
HOMEPAGE="http://www.clutter-project.org/"

SRC_URI="${SRC_URI} http://dev.gentoo.org/~pacho/gnome/${P}.tar.xz"

LICENSE="LGPL-2.1+ FDL-1.1+"
SLOT="1.0/12" # subslot = .so version
# doc and profile disable for now due bugs #484750 and #483332
IUSE="examples +introspection +opengl gles2 +pango" # doc profile
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.32:2
	x11-libs/cairo:=
	>=x11-libs/gdk-pixbuf-2:2
	x11-libs/libdrm:=
	x11-libs/libX11
	>=x11-libs/libXcomposite-0.4
	x11-libs/libXdamage
	x11-libs/libXext
	>=x11-libs/libXfixes-3
	>=x11-libs/libXrandr-1.2
	virtual/opengl
	gles2? ( media-libs/mesa[gles2] )

	introspection? ( >=dev-libs/gobject-introspection-1.34.2 )
	pango? ( >=x11-libs/pango-1.20.0[introspection?] )
"
# before clutter-1.7, cogl was part of clutter
RDEPEND="${COMMON_DEPEND}
	!<media-libs/clutter-1.7"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.13
	sys-devel/gettext
	virtual/pkgconfig
	test? (	app-admin/eselect-opengl
		media-libs/mesa[classic] )
"
#	doc? ( >=dev-util/gtk-doc-1.13 )
# Need classic mesa swrast for tests, llvmpipe causes a test failure

S="${WORKDIR}/${PN}-1.14.1"

src_configure() {
	# TODO: think about kms-egl, quartz, sdl, wayland
	# Prefer gl over gles2 if both are selected
	# Profiling needs uprof, which is not available in portage yet, bug #484750
	# FIXME: Doesn't provide prebuilt docs, but they can neither be rebuilt, bug #483332
	gnome2_src_configure \
		--disable-examples-install \
		--disable-maintainer-flags \
		--enable-cairo             \
		--enable-deprecated        \
		--enable-gdk-pixbuf        \
		--enable-glib              \
		--disable-gtk-doc	   \
		$(use_enable opengl glx)   \
		$(use_enable opengl gl)    \
		$(use_enable gles2)        \
		$(use_enable gles2 cogl-gles2) \
		$(use_enable gles2 xlib-egl-platform) \
		$(usex gles2 --with-default-driver=$(usex opengl gl gles2)) \
		$(use_enable introspection) \
		$(use_enable pango cogl-pango) \
		--disable-profile
#		$(use_enable doc gtk-doc)  \
#		$(use_enable profile)
}

src_test() {
	# Use swrast for tests, llvmpipe is incomplete and "test_sub_texture" fails
	# NOTE: recheck if this is needed after every mesa bump
	if [[ "$(eselect opengl show)" != "xorg-x11" ]]; then
		ewarn "Skipping tests because a binary OpenGL library is enabled. To"
		ewarn "run tests for ${PN}, you need to enable the Mesa library:"
		ewarn "# eselect opengl set xorg-x11"
		return
	fi
	LIBGL_DRIVERS_PATH="${EROOT}/usr/$(get_libdir)/mesa" Xemake check
}

src_install() {
	DOCS="NEWS README"
	EXAMPLES="examples/{*.c,*.jpg}"

	clutter_src_install

	# Remove silly examples-data directory
	rm -rvf "${ED}/usr/share/cogl/examples-data/" || die
}
