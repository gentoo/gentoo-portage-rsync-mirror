# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/packagekit-gtk/packagekit-gtk-0.6.22.ebuild,v 1.1 2012/05/19 11:21:32 lxnay Exp $

EAPI="3"

inherit eutils base

MY_PN="PackageKit"
MY_P=${MY_PN}-${PV}

DESCRIPTION="GTK+ PackageKit backend library"
HOMEPAGE="http://www.packagekit.org/"
SRC_URI="http://www.packagekit.org/releases/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	media-libs/fontconfig
	>=x11-libs/gtk+-2.14.0:2
	>=x11-libs/gtk+-2.91.0:3
	x11-libs/pango
	~app-admin/packagekit-base-${PV}"
DEPEND="${RDEPEND} virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-introspection=no \
		--disable-dependency-tracking \
		--enable-option-checking \
		--enable-libtool-lock \
		--disable-strict \
		--disable-local \
		--disable-gtk-doc \
		--disable-command-not-found \
		--disable-debuginfo-install \
		--disable-gstreamer-plugin \
		--disable-service-packs \
		--disable-man-pages \
		--disable-cron \
		--enable-gtk-module \
		--disable-networkmanager \
		--disable-browser-plugin \
		--disable-pm-utils \
		--disable-device-rebind \
		--disable-tests \
		--disable-qt
}

src_compile() {
	cd "${S}"/contrib/gtk-module || die
	emake || die "emake install failed"
}

src_install() {
	cd "${S}"/contrib/gtk-module || die
	emake DESTDIR="${D}" install || die "emake install failed"
}
