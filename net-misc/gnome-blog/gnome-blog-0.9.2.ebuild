# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-blog/gnome-blog-0.9.2.ebuild,v 1.6 2012/05/05 03:20:45 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Post entries to your blog right from the Gnome panel"
HOMEPAGE="http://www.gnome.org/~seth/gnome-blog/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=dev-python/pygtk-2.6

	>=dev-python/gconf-python-2
	>=dev-python/libgnome-python-2
	>=dev-python/gnome-applets-python-2
	>=dev-python/gnome-vfs-python-2
	>=dev-python/gtkspell-python-2
	>=dev-python/gdata-2"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	python_convert_shebangs -r 2 .

	# Let this file be re-created so the path in the <oaf_server> element is
	# correct. See bug #93612.
	rm -f GNOME_BlogApplet.server.in || die "rm failed"

	python_clean_py-compile_files
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize gnomeblog
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup gnomeblog
}
