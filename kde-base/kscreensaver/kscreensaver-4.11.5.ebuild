# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscreensaver/kscreensaver-4.11.5.ebuild,v 1.2 2014/01/20 08:00:04 kensington Exp $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE screensaver framework"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kcheckpass)
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.5.95-nsfw.patch"
)
