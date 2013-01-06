# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-0.7.3.ebuild,v 1.6 2012/01/21 15:51:34 klausman Exp $

EAPI="3"

PYTHON_DEPEND="2"
GCONF_DEBUG="no"
inherit eutils gnome2 python autotools

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://projects.gnome.org/nautilus-python/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE="doc"

DOCS="AUTHORS ChangeLog NEWS"
G2CONF="--docdir=${EPREFIX}/usr/share/doc/${PF}"

RDEPEND=">=dev-python/pygtk-2.8
	>=dev-python/pygobject-2.16:2
	>=gnome-base/nautilus-2.22
	<gnome-base/nautilus-2.90"
DEPEND="${RDEPEND}
	>=dev-python/gconf-python-2.12
	doc? ( >=dev-util/gtk-doc-1.9 )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# dev-python/gnome-python-base is not required actually, but configure script
	# checks for it for some unknown reason
	sed -e '/gnome-python-2.0/d' -i configure.in || die
	AT_M4DIR=m4 eautoreconf
}

src_install() {
	gnome2_src_install
	mv "${D}"/usr/share/doc/{${PN}/*,${PF}} || die
	rm -rf "${D}"/usr/share/doc/${PN}
	find "${ED}" -name '*.la' -exec rm -f {} +
	prepalldocs
}
