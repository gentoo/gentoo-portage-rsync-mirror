# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pessulus/pessulus-2.30.4.ebuild,v 1.8 2012/05/03 18:02:22 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Lockdown editor for GNOME"
HOMEPAGE="http://live.gnome.org/Pessulus"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.13.0
	dev-python/pygobject:2
	>=dev-python/libbonobo-python-2.22
	>=dev-python/bug-buddy-python-2.22
	>=dev-python/gconf-python-2.17.2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile

	python_convert_shebangs -r 2 .
}

src_install() {
	python_convert_shebangs -r 2 .
	gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize Pessulus
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup Pessulus
}
