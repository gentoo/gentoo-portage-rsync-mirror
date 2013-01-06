# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.97.1.ebuild,v 1.15 2012/05/03 20:00:39 jdhore Exp $

EAPI="3"
GCONF_DEBUG="yes"
PYTHON_DEPEND="python? 2"

inherit eutils gnome2 libtool autotools versionator python multilib

MY_P=${P/_/-}
DESCRIPTION="Diagram/flowchart creation program"
HOMEPAGE="http://live.gnome.org/Dia"
LICENSE="GPL-2"

# dia used -1 instead of .1 for the new version.
MY_PV_MM=$(get_version_component_range 1-2)
SRC_URI="mirror://gnome/sources/${PN}/${MY_PV_MM}/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
# the doc USE flag doesn't seem to do anything without docbook2html
IUSE="cairo doc gnome python"

RDEPEND=">=x11-libs/gtk+-2.6.0:2
	>=dev-libs/glib-2.6.0
	>=x11-libs/pango-1.8
	>=dev-libs/libxml2-2.3.9
	>=dev-libs/libxslt-1
	>=media-libs/freetype-2.0.95
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	>=media-libs/libart_lgpl-2
	gnome? (
		>=gnome-base/libgnome-2.0
		>=gnome-base/libgnomeui-2.0 )
	cairo? ( >=x11-libs/cairo-1 )
	python? ( >=dev-python/pygtk-1.99 )
	doc? (
		~app-text/docbook-xml-dtd-4.5
		 app-text/docbook-xsl-stylesheets )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	doc? ( dev-libs/libxslt )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog KNOWN_BUGS MAINTAINERS NEWS README RELEASE-PROCESS THANKS TODO"
	G2CONF="${G2CONF}
		$(use_with cairo)
		$(use_with python)
		$(use_enable doc db2html)
		$(use_enable gnome)
		--disable-libemf
		--without-swig
		--without-hardbooks
		--disable-static
		--docdir=${EPREFIX}/usr/share/doc/${PF}
		--exec-prefix=${EPREFIX}/usr"
	# --exec-prefix makes Python look for modules in the Prefix
	use python && python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch

	# Fix compilation in a gnome environment, bug #159831
	epatch "${FILESDIR}/${PN}-0.97.0-gnome-doc.patch"

	# Fix compilation with USE="python", bug #271855
	if use python; then
		epatch "${FILESDIR}/${PN}-0.97-acinclude-python-fixes.patch"
		# use proper shared lib extension, #298232
		sed -i -e "s/\.so/$(get_libname)/" acinclude.m4 || die
	fi

	# Skip man generation
	if ! use doc; then
		sed -i -e '/if HAVE_DB2MAN/,/endif/d' doc/*/Makefile.am \
			|| die "sed 2 failed"
	fi

	# Fix naming conflict on Darwin/OSX
	sed -i -e 's/isspecial/char_isspecial/' \
		objects/GRAFCET/boolequation.c || die

	# Don't use -DGTK_DISABLE_DEPRECATED, bug #333439
	sed -i -e 's:-DGTK_DISABLE_DEPRECATED::g' configure.in || die "sed 3 failed"

	use python && python_convert_shebangs -r 2 .

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "failed to remove *.la"
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use python; then
		python_need_rebuild
		python_mod_optimize /usr/share/dia
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	use python && python_mod_cleanup /usr/share/dia
}
