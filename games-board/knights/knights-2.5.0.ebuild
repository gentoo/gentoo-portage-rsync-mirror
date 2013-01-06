# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/knights/knights-2.5.0.ebuild,v 1.3 2012/11/23 19:38:05 ago Exp $

EAPI=4

KDE_MINIMAL="4.9"
KDE_LINGUAS="bs ca ca@valencia cs da de el es et fi fr ga gl it km lt nb nds nl
nn pl pt pt_BR ru sr sr@ijekavian sr@ijekavianlatin sr@latin sv uk zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A simple chess board for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/Knights?content=122046"
SRC_URI="http://dl.dropbox.com/u/2888238/Knights/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde4-base_pkg_postinst

	elog "No chess engines are emerged by default! If you want a chess engine"
	elog "to play with, you can emerge gnuchess or crafty."
}
