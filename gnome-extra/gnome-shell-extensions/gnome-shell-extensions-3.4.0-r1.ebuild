# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-shell-extensions/gnome-shell-extensions-3.4.0-r1.ebuild,v 1.1 2012/05/14 00:06:38 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="JavaScript extensions for GNOME Shell"
HOMEPAGE="http://live.gnome.org/GnomeShell/Extensions"
# Tarball not available from upstream website
SRC_URI="http://dev.gentoo.org/~tetromino/distfiles/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
IUSE="examples"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.26
	>=gnome-base/gnome-desktop-2.91.6:3[introspection]
	>=gnome-base/libgtop-2.28.3[introspection]
	>=app-admin/eselect-gnome-shell-extensions-20111211"
RDEPEND="${COMMON_DEPEND}
	>=dev-libs/gjs-1.29
	dev-libs/gobject-introspection
	>=gnome-base/gnome-shell-3.4.0-r1
	media-libs/clutter:1.0[introspection]
	net-libs/telepathy-glib[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.50
	virtual/pkgconfig
	gnome-base/gnome-common"

pkg_setup() {
	DOCS="NEWS README"
	G2CONF="${G2CONF}
		--enable-extensions=all
		--disable-schemas-compile"
}

src_prepare() {
	# Useful upstream patches
	epatch "${FILESDIR}/${P}-places-menu-align.patch"
	epatch "${FILESDIR}/${P}-windowsNavigator-tooltip-crash.patch"
	epatch "${FILESDIR}/${P}-auto-move-windows-removed-crash.patch"

	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	local example="example@gnome-shell-extensions.gcampax.github.com"
	if use examples; then
		mv "${ED}usr/share/gnome-shell/extensions/${example}" \
			"${ED}usr/share/doc/${PF}/" || die
	else
		rm -r "${ED}usr/share/gnome-shell/extensions/${example}" || die
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst

	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
	elog
	elog "Installed extensions installed are initially disabled by default."
	elog "To change the system default and enable some extensions, you can use"
	elog "# eselect gnome-shell-extensions"
	elog "Alternatively, to enable/disable extensions on a per-user basis,"
	elog "you can use the https://extensions.gnome.org/ web interface, the"
	elog "gnome-extra/gnome-tweak-tool GUI, or modify the org.gnome.shell"
	elog "enabled-extensions gsettings key from the command line or a script."
	elog
	elog "In ${PN}-3.2.2, extension IDs have changed from"
	elog "*.gnome.org to *.gcampax.github.com. As a result, extensions may"
	elog "have become disabled, and you will need to re-enable them."
}
