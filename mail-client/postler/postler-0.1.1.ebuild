# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/postler/postler-0.1.1.ebuild,v 1.4 2013/03/29 21:27:25 angelos Exp $

EAPI=4
inherit gnome2-utils python waf-utils vala

DESCRIPTION="A super sexy, ultra simple desktop mail client built in vala"
HOMEPAGE="http://launchpad.net/postler"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="" # ayatana, disabled because we only support GTK+-3.x with ayatana libs in purpose

RDEPEND=">=dev-libs/glib-2.26
	dev-libs/libunique:1
	dev-libs/openssl:0
	mail-mta/msmtp
	media-libs/libcanberra
	net-libs/webkit-gtk:2
	sys-libs/db
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/libnotify-0.7"
# ayatana? ( dev-libs/libindicate )"
DEPEND="${RDEPEND}
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	$(vala_depend)
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e 's:Categories=.*:&Office;:' data/${PN}.desktop.in || die
	base_src_prepare
	vala_src_prepare
}

src_configure() {
	waf-utils_src_configure \
		--disable-docs \
		--disable-libindicate
# $(use_enable ayatana libindicate)
}

src_install() {
	waf-utils_src_install
	dodoc ChangeLog README
}

src_test() {
	"${WAF_BINARY}" check || die
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
