# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do/gnome-do-0.8.5.ebuild,v 1.4 2012/06/21 09:35:12 jlec Exp $

# TODO: GNOME Do defaults to a debug build; to disable, --enable-release must
# be passed. However, when doing this the build fails; figure out why.

EAPI=2

inherit gnome2 mono versionator eutils autotools

PVC=$(get_version_component_range 1-3)

DESCRIPTION="GNOME Do allows you to get things done quickly"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/do/trunk/${PVC}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/gtk-sharp-2.12.6
	>=dev-dotnet/glade-sharp-2.12.6
	dev-dotnet/ndesk-dbus
	dev-dotnet/ndesk-dbus-glib
	>=dev-dotnet/gnome-desktop-sharp-2.26.0
	>=dev-dotnet/gnome-keyring-sharp-1.0.0
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/wnck-sharp-2.24.0
	>=dev-dotnet/art-sharp-2.24.0
	>=dev-dotnet/rsvg-sharp-2.24.0
	dev-dotnet/mono-addins[gtk]
	dev-dotnet/notify-sharp
	!<gnome-extra/gnome-do-plugins-0.8"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
#	epatch "${FILESDIR}"/${P}-mono-2.8.patch
	epatch "${FILESDIR}"/${P}-glib-2.32.patch

	# Drop DEPRECATED flags
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED::g' \
		configure.ac || die

	# The same for -Werror
	sed -i -e 's:-Werror::' configure.ac || die

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}

pkg_postinst() {
	gnome2_pkg_postinst
}
