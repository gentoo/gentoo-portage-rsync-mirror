# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dragon/dragon-4.14.1.ebuild,v 1.1 2014/09/16 18:17:27 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Dragon Player is a simple video player for KDE 4"
HOMEPAGE="http://www.kde.org/applications/multimedia/dragonplayer"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug xine"

RDEPEND="
	media-libs/phonon[qt4]
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
