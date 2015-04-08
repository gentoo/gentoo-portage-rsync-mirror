# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/pybliographer/pybliographer-1.2.15.ebuild,v 1.3 2012/08/10 11:21:47 blueness Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit autotools gnome2 python

DESCRIPTION="Pybliographer is a tool for working with bibliographic databases"
HOMEPAGE="http://pybliographer.org/"
SRC_URI="mirror://sourceforge/pybliographer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DOCS="AUTHORS ChangeLog* NEWS TODO README"

DEPEND=">=app-text/recode-3.6-r1
	app-text/scrollkeeper
	dev-libs/glib:2
	dev-python/gconf-python:2
	dev-python/gnome-vfs-python:2
	dev-python/libgnome-python:2
	dev-python/pygobject:2
	dev-python/pygtk:2
	>=dev-python/python-bibtex-1.2.5"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# Disable byte-compilation of Python modules.
	sed -i \
		-e "/import compileall/d" \
		Makefile.am || die "sed failed"

	# Install Python modules into site-packages directories.
	find -name Makefile.am | xargs sed -i \
		-e "/^pybdir[[:space:]]*=[[:space:]]*/s:\$(datadir):$(python_get_sitedir):" || die "sed failed"
	sed -i \
		-e "s:\${datadir}/@PACKAGE@:$(python_get_sitedir)/@PACKAGE@:" \
		etc/installer.in || die "sed failed"
	sed -i \
		-e "s:gladedir = \$(datadir):gladedir = $(python_get_sitedir):" \
		Pyblio/GnomeUI/glade/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	gnome2_src_configure --disable-depchecks
}

src_install() {
	gnome2_src_install
	python_convert_shebangs -r 2 "${ED}usr/bin"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize pybliographer
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup pybliographer
}
