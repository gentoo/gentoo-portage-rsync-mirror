# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/accountsservice/accountsservice-0.6.22.ebuild,v 1.6 2013/01/07 00:39:40 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 systemd

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="http://www.fedoraproject.org/wiki/Features/UserAccountDialog"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha amd64 arm x86"
IUSE="doc +introspection vala" # systemd
REQUIRED_USE="vala? ( introspection )"

# Want glib-2.30 for gdbus
RDEPEND=">=dev-libs/glib-2.30:2
	sys-auth/polkit
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	sys-auth/consolekit"
#	systemd? ( >=sys-apps/systemd-43 )
#	!systemd? ( sys-auth/consolekit )
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto )
	vala? ( >=dev-lang/vala-0.16.1-r1:0.16[vapigen] )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-more-warnings
		--localstatedir=${EPREFIX}/var
		--docdir=${EPREFIX}/usr/share/doc/${PF}
		$(use_enable doc docbook-docs)
		$(use_enable introspection)
		$(use_enable vala)
		$(systemd_with_unitdir)
		--disable-systemd"
#		$(use_enable systemd)
	DOCS="AUTHORS NEWS README TODO"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.21-gentoo-system-users.patch"
	gnome2_src_prepare

	# FIXME: write a sane version of vapigen.m4 that properly deals with
	# versioned vapigen pkgconfig files, submit to vala upstream, and get
	# ${PN} upstream to use it.
	sed -e 's:vapigen_pkg_name=vapigen$:vapigen_pkg_name=vapigen-0.16:' \
		-e 's: vapigen\([^a-z_-]\): $vapigen_pkg_name\1:' \
		-i configure || die 'sed failed'
}
