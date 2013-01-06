# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-light/gnome-light-3.6.2.ebuild,v 1.1 2012/12/26 23:19:33 eva Exp $

EAPI="5"

DESCRIPTION="Meta package for GNOME-Light, merge this package to install"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="2.0"
IUSE="cups +fallback +gnome-shell"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~amd64 ~x86"

# XXX: Note to developers:
# This is a wrapper for the 'light' GNOME 3 desktop, and should only consist of
# the bare minimum of libs/apps needed. It is basically gnome-base/gnome without
# any apps, but shouldn't be used by users unless they know what they are doing.
RDEPEND="!gnome-base/gnome
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=gnome-base/gnome-session-${PV}
	>=gnome-base/gnome-menus-3.6.1:3
	>=gnome-base/gnome-settings-daemon-${PV}[cups?]
	>=gnome-base/gnome-control-center-${PV}[cups?]

	>=gnome-base/nautilus-${PV}

	gnome-shell? (
		>=x11-wm/mutter-${PV}
		>=gnome-base/gnome-shell-${PV} )

	fallback? ( >=gnome-base/gnome-fallback-${PV} )

	>=x11-themes/gnome-icon-theme-3.6.2
	>=x11-themes/gnome-icon-theme-symbolic-3.6.2
	>=x11-themes/gnome-themes-standard-${PV}

	>=x11-terms/gnome-terminal-3.6.1
"
DEPEND=""
PDEPEND=">=gnome-base/gvfs-1.14.2"
S="${WORKDIR}"

pkg_pretend() {
	if ! use fallback && ! use gnome-shell; then
		# Users probably want to use e16, sawfish, etc
		ewarn "You're installing neither GNOME Shell nor GNOME Fallback!"
		ewarn "You will have to install and manage a window manager by yourself"
		# https://bugs.gentoo.org/show_bug.cgi?id=303375
		ewarn "See: <add link to docs about component handling in gnome-session>"
	fi
}
