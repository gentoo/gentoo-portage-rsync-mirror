# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.13.4.ebuild,v 1.9 2012/05/05 02:54:30 jdhore Exp $

EAPI=2

DESCRIPTION="an object-oriented framework for creating UPnP devs and control points."
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE="+introspection networkmanager"

RDEPEND=">=net-libs/gssdp-0.7.1[introspection?]
	>=net-libs/libsoup-2.4.1:2.4[introspection?]
	>=dev-libs/glib-2.18:2
	dev-libs/libxml2
	|| ( >=sys-apps/util-linux-2.16 <sys-libs/e2fsprogs-libs-1.41.8 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	networkmanager? ( >=dev-libs/dbus-glib-0.76 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	local backend=unix
	use networkmanager && backend=network-manager

	econf \
		$(use_enable introspection) \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--with-context-manager=${backend} \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
