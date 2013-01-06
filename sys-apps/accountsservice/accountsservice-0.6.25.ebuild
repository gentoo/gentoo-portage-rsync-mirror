# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/accountsservice/accountsservice-0.6.25.ebuild,v 1.1 2012/09/30 09:14:01 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"

inherit eutils gnome2 systemd vala

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="http://www.fedoraproject.org/wiki/Features/UserAccountDialog"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="doc +introspection systemd vala"
REQUIRED_USE="vala? ( introspection )"

# Want glib-2.30 for gdbus
RDEPEND=">=dev-libs/glib-2.30:2
	sys-auth/polkit
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	systemd? ( >=sys-apps/systemd-43 )
	!systemd? ( sys-auth/consolekit )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto )
	vala? (
		>=dev-lang/vala-0.16.1-r1
		$(vala_depend) )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-more-warnings
		--localstatedir="${EPREFIX}"/var
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable doc docbook-docs)
		$(use_enable introspection)
		$(use_enable vala)
		$(use_enable systemd)
		$(systemd_with_unitdir)"
	DOCS="AUTHORS NEWS README TODO"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.21-gentoo-system-users.patch"
	use vala && vala_src_prepare
	gnome2_src_prepare
}
