# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/postr/postr-0.13.ebuild,v 1.2 2013/02/07 22:28:22 ulm Exp $

EAPI="4"

GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="xml"

inherit eutils gnome2 python

DESCRIPTION="Flickr uploader for GNOME"
HOMEPAGE="http://projects.gnome.org/postr/"

LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome2"

COMMON_DEPEND="dev-python/pygtk:2
	gnome2? (
		>=dev-python/nautilus-python-0.6.1
		<dev-python/nautilus-python-1.0 )"
RDEPEND="${COMMON_DEPEND}
	dev-python/bsddb3
	dev-python/dbus-python
	dev-python/gconf-python
	dev-python/gtkspell-python
	dev-python/libgnome-python
	dev-python/pygobject:2
	dev-python/twisted
	dev-python/twisted-web"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-nautilus-extension-dir=${EPREFIX}/usr/share/nautilus-python/extensions"
	python_pkg_setup
}

src_prepare() {
	# In next release
	epatch "${FILESDIR}/${P}-exception-after-quit.patch"

	python_clean_py-compile_files
	python_convert_shebangs 2 postr
	if ! use gnome2; then
		# Don't check for nautilus-python if we aren't installing the extension
		sed -e 's:nautilus-python >= 0.6.1::' -i configure || die
	fi
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	# In next release, https://bugzilla.gnome.org/show_bug.cgi?id=685454
	mv "${ED}usr/share/postr/postr.glade" "${ED}$(python_get_sitedir)/postr/" || die
	if ! use gnome2; then
		rm -r "${ED}usr/share/nautilus-python" || die
	fi
}

pkg_postinst() {
	python_mod_optimize postr
	use gnome2 && python_mod_optimize /usr/share/nautilus-python/extensions/postrExtension.py
	gnome2_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup postr
	use gnome2 && python_mod_cleanup /usr/share/nautilus-python/extensions/postrExtension.py
	gnome2_pkg_postrm
}
