# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-9999.ebuild,v 1.48 2012/12/11 05:43:44 patrick Exp $

EAPI="3"
PYTHON_DEPEND="python? 2:2.5"

inherit git-2 eutils gnome2 fdo-mime multilib python

EGIT_REPO_URI="git://git.gnome.org/gimp"

DESCRIPTION="GNU Image Manipulation Program"
HOMEPAGE="http://www.gimp.org/"
SRC_URI=""

LICENSE="GPL-3 LGPL-3"
SLOT="2"
KEYWORDS=""

IUSE="alsa aalib altivec bzip2 curl dbus debug doc exif gnome postscript jpeg jpeg2k lcms mmx mng pdf png python smp sse svg tiff udev webkit wmf xpm"

RDEPEND=">=dev-libs/glib-2.30.2:2
	>=dev-libs/atk-2.2.0
	>=x11-libs/gtk+-2.24.10:2
	>=x11-libs/gdk-pixbuf-2.24.1:2
	>=x11-libs/cairo-1.10.2
	>=x11-libs/pango-1.29.4
	xpm? ( x11-libs/libXpm )
	>=media-libs/freetype-2.1.7
	>=media-libs/fontconfig-2.2.0
	sys-libs/zlib
	dev-libs/libxml2
	dev-libs/libxslt
	x11-themes/hicolor-icon-theme
	>=media-libs/babl-0.1.11
	>=media-libs/gegl-0.2.1
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	dbus? ( dev-libs/dbus-glib )
	gnome? ( gnome-base/gvfs )
	webkit? ( >=net-libs/webkit-gtk-1.6.1:2 )
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/jasper )
	exif? ( >=media-libs/libexif-0.6.15 )
	lcms? ( >=media-libs/lcms-1.16:0 )
	mng? ( media-libs/libmng )
	pdf? ( >=app-text/poppler-0.12.4[cairo] )
	png? ( >=media-libs/libpng-1.2.37:0 )
	python?	( >=dev-python/pygtk-2.10.4:2 )
	tiff? ( >=media-libs/tiff-3.5.7:0 )
	svg? ( >=gnome-base/librsvg-2.34.2:2 )
	wmf? ( >=media-libs/libwmf-0.2.8 )
	x11-libs/libXcursor
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )
	postscript? ( app-text/ghostscript-gpl )
	udev? ( virtual/udev[gudev] )"
DEPEND="${RDEPEND}
	sys-apps/findutils
	virtual/pkgconfig
	>=dev-util/intltool-0.40.1
	>=sys-devel/gettext-0.17
	doc? ( >=dev-util/gtk-doc-1 )
	>=sys-devel/libtool-2.2
	>=sys-devel/autoconf-2.54
	>=sys-devel/automake-1.11
	dev-util/gtk-doc-am"  # due to our call to eautoreconf below (bug #386453)

DOCS="AUTHORS ChangeLog* HACKING NEWS README*"

pkg_setup() {
	G2CONF="--enable-default-binary \
		--with-x \
		$(use_with aalib aa) \
		$(use_with alsa) \
		$(use_enable altivec) \
		$(use_with bzip2) \
		$(use_with curl libcurl) \
		$(use_with dbus) \
		$(use_with gnome gvfs) \
		$(use_with webkit) \
		$(use_with jpeg libjpeg) \
		$(use_with jpeg2k libjasper) \
		$(use_with exif libexif) \
		$(use_with lcms) \
		$(use_with postscript gs) \
		$(use_enable mmx) \
		$(use_with mng libmng) \
		$(use_with pdf poppler) \
		$(use_with png libpng) \
		$(use_enable python) \
		$(use_enable smp mp) \
		$(use_enable sse) \
		$(use_with svg librsvg) \
		$(use_with tiff libtiff) \
		$(use_with udev gudev) \
		$(use_with wmf) \
		--with-xmc \
		$(use_with xpm libxpm) \
		--without-xvfb-run"

	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	echo '#!/bin/sh' > py-compile
	chmod a+x py-compile || die
	sed -i -e 's:\$srcdir/configure:#:g' autogen.sh
	local myconf
	if ! use doc; then
	    myconf="${myconf} --disable-gtk-doc"
	fi
	./autogen.sh ${myconf} || die
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	if use python; then
		python_convert_shebangs -r $(python_get_version) "${ED}"
		python_need_rebuild
	fi

	# Workaround for bug #321111 to give GIMP the least
	# precedence on PDF documents by default
	mv "${D}"/usr/share/applications/{,zzz-}gimp.desktop || die

	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	gnome2_pkg_postinst

	use python && python_mod_optimize /usr/$(get_libdir)/gimp/2.0/python \
		/usr/$(get_libdir)/gimp/2.0/plug-ins
}

pkg_postrm() {
	gnome2_pkg_postrm

	use python && python_mod_cleanup /usr/$(get_libdir)/gimp/2.0/python \
		/usr/$(get_libdir)/gimp/2.0/plug-ins
}
