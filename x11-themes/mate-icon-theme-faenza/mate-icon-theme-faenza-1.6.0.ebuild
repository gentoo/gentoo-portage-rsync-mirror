# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mate-icon-theme-faenza/mate-icon-theme-faenza-1.6.0.ebuild,v 1.1 2014/03/19 17:21:41 tomwij Exp $

EAPI="5"

inherit autotools gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Faenza icon theme, that was adapted for MATE desktop"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="minimal"

RDEPEND="!minimal? ( >=x11-themes/mate-icon-theme-1.6:0 )
	x11-themes/hicolor-icon-theme:0"

RESTRICT="binchecks strip"

src_prepare() {
	# Tarball has no proper build system, should be fixed on next release.
	eautoreconf

	gnome2_src_prepare

	# Remove broken libreoffice icons (dangling symlinks).
	rm matefaenza/apps/16/*libreoffice* || die

	# TODO: Fix cache generation.
}
