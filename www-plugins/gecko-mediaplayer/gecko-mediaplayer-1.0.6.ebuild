# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-1.0.6.ebuild,v 1.4 2012/06/08 11:31:39 phajdan.jr Exp $

EAPI=4
inherit multilib nsplugins

DESCRIPTION="A browser plugin that uses GNOME MPlayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="+curl"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.26
	dev-libs/nspr
	>=media-libs/gmtk-${PV}
	>=media-video/gnome-mplayer-${PV}[dbus]
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	>=net-misc/npapi-sdk-0.27
	sys-devel/gettext"

DOCS="ChangeLog DOCS/tech/*.txt"

src_configure() {
	econf \
		--with-plugin-dir=/usr/$(get_libdir)/${PLUGINS_DIR} \
		$(use_with curl libcurl)
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/${PN}
}
