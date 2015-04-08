# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.11-r1.ebuild,v 1.2 2014/04/24 15:29:07 johu Exp $

EAPI=5

KDE_LINGUAS="ar be ca cs da de el en_GB es et fr ga gl hi hne is it ja km ko lt
ml nb nds nl nn oc pl pt pt_BR ro ru se sk sv tr uk zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Small utility which bothers you at certain intervals"
HOMEPAGE="http://userbase.kde.org/RSIBreak"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep knotify)
"
