# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyorbit/pyorbit-2.24.0.ebuild,v 1.17 2012/05/04 15:12:14 patrick Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit gnome2 multilib python

DESCRIPTION="ORBit2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=gnome-base/orbit-2.12"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

src_prepare() {
	# disable pyc compiling
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile

	python_copy_sources
}

src_configure() {
	python_execute_function -s gnome2_src_configure
}

src_compile() {
	python_execute_function -s gnome2_src_compile
}

src_test() {
	python_execute_function -s -d
}

src_install() {
	installation() {
		gnome2_src_install

		mv "${ED}"$(python_get_sitedir)/{CORBA.py,pyorbit_CORBA.py}
		mv "${ED}"$(python_get_sitedir)/{PortableServer.py,pyorbit_PortableServer.py}
	}
	python_execute_function -s installation
	python_clean_installation_image
}

pkg_postinst() {
	python_mod_optimize pyorbit_CORBA.py pyorbit_PortableServer.py
}

pkg_postrm() {
	python_mod_cleanup pyorbit_CORBA.py pyorbit_PortableServer.py
}
