# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/blogtk/blogtk-2.0-r1.ebuild,v 1.1 2013/01/17 15:48:22 pacho Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils fdo-mime multilib python-single-r1

DESCRIPTION="GTK Blog - post entries to your blog"
HOMEPAGE="http://blogtk.sourceforge.net"
SRC_URI="http://launchpad.net/${PN}/${PV}/${PV}/+download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="mirror"

RDEPEND=">=dev-python/pygtk-2:2
	>=dev-python/pygobject-2:2
	>=gnome-base/gconf-2.2:2
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

	# Fix desktop file
	sed -i -e 's/.png//' data/blogtk.desktop || die
	sed -i -e 's/Application;//' data/blogtk.desktop || die

	python_fix_shebang .
}

src_compile() {
	return
}
