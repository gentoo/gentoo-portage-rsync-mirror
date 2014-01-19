# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-3.8.0-r1.ebuild,v 1.5 2014/01/19 19:59:41 pacho Exp $

EAPI="5"

DESCRIPTION="Meta package for GNOME 3, merge this package to install"
HOMEPAGE="http://www.gnome.org/"

LICENSE="metapackage"
SLOT="2.0" # Cannot be installed at the same time as gnome-2

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"

IUSE="accessibility +bluetooth +classic +cdr cups +extras flashback"

S=${WORKDIR}

# TODO: check accessibility completeness
# GDM-3.0 integrates very nicely with GNOME Shell
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]
	>=gnome-base/gnome-core-apps-${PV}[cups?,bluetooth?,cdr?]

	>=gnome-base/gdm-${PV}

	>=x11-wm/mutter-${PV}
	>=gnome-base/gnome-shell-${PV}[bluetooth?]

	>=x11-themes/gnome-backgrounds-${PV}
	>=x11-themes/gnome-icon-theme-extras-3.6.2
	x11-themes/sound-theme-freedesktop

	accessibility? (
		>=app-accessibility/at-spi2-atk-2.8
		>=app-accessibility/at-spi2-core-2.8
		>=app-accessibility/caribou-0.4.4.2
		>=app-accessibility/orca-3.6.3-r1
		>=gnome-extra/mousetweaks-${PV} )
	classic? ( >=gnome-extra/gnome-shell-extensions-${PV} )
	extras? ( >=gnome-base/gnome-extra-apps-${PV} )
	flashback? (
		>=gnome-base/gnome-fallback-${PV} )
"

DEPEND=""

PDEPEND="|| ( >=gnome-base/gvfs-1.12.1[udisks] >=gnome-base/gvfs-1.12.1[gdu] )"

# Broken from assumptions of gnome-vfs headers being included in nautilus headers,
# which isn't the case with nautilus-2.22, bug #216019
#	>=app-admin/gnome-system-tools-2.32.0
#	>=app-admin/system-tools-backends-2.8

# Not ported:
#   bug-buddy-2.32
#   sound-juicer-2.32
#
# Not ported, don't build:
#	gnome-extra/evolution-webcal-2.32.0

# These don't work with gsettings/dconf
#	>=app-admin/pessulus-2.30.4
#	ldap? (	>=app-admin/sabayon-2.30.1 )

# I'm not sure what all is in a11y for GNOME 3 yet ~nirbheek
#	accessibility? (
#		>=gnome-extra/libgail-gnome-1.20.3
#		>=gnome-extra/at-spi-1.32.0:1
#		>=app-accessibility/dasher-4.11
#		>=app-accessibility/gnome-mag-0.16.3:1
#		>=app-accessibility/gnome-speech-0.4.25:1
#		>=app-accessibility/gok-2.30.1:1
#		>=app-accessibility/orca-2.32.1
#		>=gnome-extra/mousetweaks-2.32.1 )

# Useless with GNOME Shell
#	>=gnome-extra/deskbar-applet-2.32.0
#	>=gnome-extra/hamster-applet-2.32.1

# Development tools
#   scrollkeeper
#   pkgconfig
#   intltool
#   gtk-doc
#   gnome-doc-utils
#   itstool
#   yelp-tools
