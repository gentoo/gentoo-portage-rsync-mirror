# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtksourceview/pygtksourceview-2.10.1.ebuild,v 1.14 2012/05/15 23:24:32 aballier Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython 2.7-pypy-*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit gnome2 python

DESCRIPTION="GTK+2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND=">=dev-python/pygobject-2.15.2:2
	>=dev-python/pygtk-2.8:2
	>=x11-libs/gtksourceview-2.9.7:2.0"

DEPEND="${RDEPEND}
	doc? (
		>=dev-util/gtk-doc-1.10
		dev-libs/libxslt
		~app-text/docbook-xml-dtd-4.1.2
		>=app-text/docbook-xsl-stylesheets-1.70.1 )
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} $(use_enable doc docs)"
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	python_src_prepare
}

src_configure() {
	python_execute_function -s gnome2_src_configure
}

src_install() {
	python_execute_function -s gnome2_src_install
	python_clean_installation_image
}
