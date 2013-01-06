# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-tools-backends/system-tools-backends-2.10.1.ebuild,v 1.9 2012/05/31 02:45:53 zmedico Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2 user

DESCRIPTION="Tools aimed to make easy the administration of UNIX systems"
HOMEPAGE="http://www.gnome.org/projects/gst/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="!<app-admin/gnome-system-tools-1.1.91
	>=sys-apps/dbus-1.1.2
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.15.2
	>=dev-perl/Net-DBus-0.33.4
	dev-lang/perl
	>=sys-auth/polkit-0.94
	userland_GNU? ( virtual/shadow )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--localstatedir=/var"

	enewgroup stb-admin
}

src_prepare() {
	gnome2_src_prepare

	# Change default permission, only people in stb-admin is allowed
	# to speak to the dispatcher.
	epatch "${FILESDIR}/${PN}-2.8.2-default-permissions.patch"

	# Apply fix from ubuntu for CVE 2008 4311
	epatch "${FILESDIR}/${PN}-2.8.2-cve-2008-4311.patch"
}

src_install() {
	gnome2_src_install
	newinitd "${FILESDIR}"/stb.rc system-tools-backends
}

pkg_postinst() {
	echo
	elog "You need to add yourself to the group stb-admin and"
	elog "add system-tools-backends to the default runlevel."
	elog "You can do this as root like so:"
	elog "  # rc-update add system-tools-backends default"
	echo
}
