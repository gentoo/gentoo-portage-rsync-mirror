# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catfish/catfish-0.6.4.ebuild,v 1.4 2013/10/13 09:12:59 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )
inherit gnome2-utils python-single-r1

DESCRIPTION="A frontend for find, (s)locate, doodle, tracker, beagle, strigi and pinot"
HOMEPAGE="http://launchpad.net/catfish-search http://twotoasts.de/index.php/catfish/"
SRC_URI="http://launchpad.net/${PN}-search/${PV%.*}/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang .
	sed -i -e "s:share/doc/\$(APPNAME):share/doc/${PF}:" Makefile.in.in || die
}

src_configure() {
	./configure --prefix=/usr --python="${EPYTHON}" || die
}

src_install() {
	emake DESTDIR="${D}" install
	python_optimize "${ED}"/usr/share/${PN}
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
