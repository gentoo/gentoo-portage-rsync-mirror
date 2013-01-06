# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blogtk/blogtk-2.0.ebuild,v 1.8 2012/05/05 03:20:40 jdhore Exp $

EAPI="2"
PYTHON_DEPEND="2:2.6"

inherit eutils fdo-mime multilib python

DESCRIPTION="GTK Blog - post entries to your blog"
HOMEPAGE="http://blogtk.sourceforge.net"
SRC_URI="http://launchpad.net/${PN}/${PV}/${PV}/+download/${PF}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RESTRICT="mirror"

RDEPEND=">=dev-python/pygtk-2
	>=dev-python/pygobject-2:2
	>=gnome-base/gconf-2.2
	>=gnome-base/libgnome-2
	dev-python/gdata
	dev-python/feedparser
	dev-python/libgnome-python
	dev-python/gtkspell-python
	dev-python/pywebkitgtk
	dev-python/pygtksourceview"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

src_prepare() {
	# Respect DESTDIR
	epatch "${FILESDIR}/${P}-destdir.patch"

	# Respect multilib
	sed -i "s:lib/blogtk:$(get_libdir)/blogtk:g" Makefile || die "sed 1 failed"
	sed -i "s:blogtk2', 'lib')):blogtk2', '$(get_libdir)')):g" bin/blogtk2 \
		|| die "sed 2 failed"
	if [ "$(get_libdir)" != "lib" ]; then
		mv share/blogtk2/lib share/blogtk2/$(get_libdir) || die
	fi

	# Remove unwanted files
	find -name "*~" -delete || die
	find -name "*.pyc" -delete || die
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "Unable to compile blogtk"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	python_mod_optimize /usr/share/${PN}2/$(get_libdir)/${PN}2
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	python_mod_cleanup /usr/share/${PN}2/$(get_libdir)/${PN}2
}
