# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/upower-pm-utils/upower-pm-utils-0.9.23.ebuild,v 1.4 2014/06/02 12:48:21 ssuominen Exp $

EAPI=5
inherit eutils systemd

DESCRIPTION="The upstream upower 0.9 git branch for use with sys-power/pm-utils"
HOMEPAGE="http://upower.freedesktop.org/"
SRC_URI="http://upower.freedesktop.org/releases/upower-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc +introspection ios kernel_FreeBSD kernel_linux"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.100
	>=dev-libs/glib-2.22
	sys-apps/dbus
	>=sys-auth/polkit-0.110
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? (
		virtual/libusb:1
		virtual/libgudev:=
		virtual/udev
		ios? (
			>=app-pda/libimobiledevice-1:=
			>=app-pda/libplist-1:=
			)
		)
	!sys-power/upower"
RDEPEND="${COMMON_DEPEND}
	kernel_linux? ( >=sys-power/pm-utils-1.4.1 )"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	dev-util/intltool
	virtual/pkgconfig
	doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2
		)"

QA_MULTILIB_PATHS="usr/lib/upower/.*"

DOCS="AUTHORS HACKING NEWS README"

S=${WORKDIR}/upower-${PV}

src_prepare() {
	sed -i -e '/DISABLE_DEPRECATED/d' configure || die

	epatch \
		"${FILESDIR}"/${P}-create-dir-runtime.patch \
		"${FILESDIR}"/${P}-fix-segfault.patch \
		"${FILESDIR}"/${P}-clamp_percentage_for_overfull_batt.patch
}

src_configure() {
	local backend myconf

	if use kernel_linux; then
		backend=linux
		myconf="--enable-deprecated"
	elif use kernel_FreeBSD; then
		backend=freebsd
	else
		backend=dummy
	fi

	econf \
		--libexecdir="${EPREFIX}"/usr/lib/upower \
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
