# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dragon/dragon-4.9.3.ebuild,v 1.4 2012/11/30 15:18:21 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="dragon"
inherit kde4-base

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug xine"

RDEPEND="
	>=media-libs/phonon-4.4.3
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
add_blocker dragonplayer
