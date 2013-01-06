# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catfish/catfish-0.3.2.ebuild,v 1.2 2012/02/05 01:41:24 floppym Exp $

EAPI=4
PYTHON_DEPEND="2:2.7"
inherit eutils gnome2-utils multilib python

DESCRIPTION="A frontend for find, (s)locate, doodle, tracker, beagle, strigi and pinot"
HOMEPAGE="http://software.twotoasts.de/index.php?/pages/catfish_summary.html"
SRC_URI="http://www.twotoasts.de/media/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	>=dev-python/pygtk-2
	dev-python/pyxdg"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gentoo.patch

	python_convert_shebangs 2 {build,catfish}.py

	cat <<-EOF > "${T}"/${PN}
	#!/bin/sh
	cd /usr/$(get_libdir)/${PN}
	python2 ${PN}.pyc "\$@"
	EOF
}

src_configure() {
	./configure --prefix=/usr || die
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="$(get_libdir)" install

	dobin "${T}"/${PN}

	dodoc AUTHORS ChangeLog README TODO
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
	gnome2_icon_cache_update
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	gnome2_icon_cache_update
}
