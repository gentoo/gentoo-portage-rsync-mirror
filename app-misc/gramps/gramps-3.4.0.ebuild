# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-3.4.0.ebuild,v 1.5 2012/10/17 03:38:19 phajdan.jr Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
GCONF_DEBUG="no"

inherit eutils gnome2 python

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://www.gramps-project.org/"
SRC_URI="mirror://sourceforge/gramps/Stable/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnome reports spell webkit"

RDEPEND="dev-python/bsddb3
	>=dev-python/pygtk-2.16.0
	dev-python/pygoocanvas
	x11-misc/xdg-utils
	gnome-base/librsvg:2
	gnome? ( dev-python/libgnome-python
		dev-python/gconf-python )
	spell? ( dev-python/gtkspell-python )
	reports? ( media-gfx/graphviz )
	webkit? ( dev-python/pywebkitgtk )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/libiconv
	virtual/pkgconfig"

DOCS="NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-mime-install PYTHON="${EROOT}"/usr/bin/python2"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	epatch "${FILESDIR}/${P}-use_bsddb3.patch"

	# This is for bug 215944, so .pyo/.pyc files don't get into the
	# file system
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile

	# Fix install path, bug 423315 for example
	einfo "Fix installation path"
	find . -iname 'Makefile.in' | xargs \
		sed "s;\(pkgdatadir = \)\(\$(datadir)\);\1$(python_get_sitedir);" -i \
		|| die
	find . -iname 'Makefile.in' | xargs \
		sed "s;\(pkgpythondir = \)\(\$(datadir)\);\1$(python_get_sitedir);" -i \
		|| die

	sed "s;\$(prefix)/share/gramps;/$(python_get_sitedir)/@PACKAGE@;" \
		-i src/Makefile.in || die

	sed "s;\$(prefix)/share/gramps;/$(python_get_sitedir)/@PACKAGE@;" \
	-i src/docgen/Makefile.in || die

	einfo "Fix wrapper script"
	sed "s;@datadir@;$(python_get_sitedir);" \
		-i gramps.sh.in || die

	einfo "Fix icon location"
	sed "s;gramps/;pixmap/;g" -i data/gramps.keys.in || die
}

src_install() {
	python_need_rebuild
	gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize ${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup ${PN}
}
