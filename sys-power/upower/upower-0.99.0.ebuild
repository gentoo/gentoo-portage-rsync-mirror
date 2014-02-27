# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/upower/upower-0.99.0.ebuild,v 1.1 2014/02/27 11:26:29 ssuominen Exp $

EAPI=5
inherit eutils systemd

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://upower.freedesktop.org/"
SRC_URI="http://${PN}.freedesktop.org/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0/2" # based on SONAME of libupower-glib.so
#There has been major API change, so temporarily leave without KEYWORDS and
#possibly wait for 0.100 -like release?
#KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc +introspection ios kernel_FreeBSD kernel_linux systemd"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.100
	>=dev-libs/glib-2.30
	sys-apps/dbus
	>=sys-auth/polkit-0.110
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? (
		virtual/libusb:1
		>=virtual/udev-200[gudev]
		ios? (
			>=app-pda/libimobiledevice-1:=
			>=app-pda/libplist-1:=
			)
		)"
RDEPEND="${COMMON_DEPEND}
	kernel_linux? (
		!systemd? ( >=sys-power/pm-utils-1.4.1 )
		systemd? (
			app-shells/bash
			>=sys-apps/systemd-200
			)
		)"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	dev-util/intltool
	virtual/pkgconfig
	doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2
		)"

QA_MULTILIB_PATHS="usr/lib/${PN}/.*"

DOCS="AUTHORS HACKING NEWS README"

src_prepare() {
	sed -i -e '/DISABLE_DEPRECATED/d' configure || die
}

src_configure() {
	local backend myconf

	if use kernel_linux; then
		backend=linux
		myconf="$(use_enable !systemd deprecated)"
	elif use kernel_FreeBSD; then
		backend=freebsd
	else
		backend=dummy
	fi

	econf \
		--libexecdir="${EPREFIX}"/usr/lib/${PN} \
		--localstatedir="${EPREFIX}"/var \
		$(use_enable introspection) \
		--disable-static \
		${myconf} \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		--disable-tests \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--with-backend=${backend} \
		$(use_with ios idevice) \
		"$(systemd_with_utildir)" \
		"$(systemd_with_unitdir)"
}

src_install() {
	default
	keepdir /var/lib/upower #383091
	prune_libtool_files
}
