# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kgraphviewer/kgraphviewer-2.1.1.ebuild,v 1.4 2014/03/21 20:48:18 johu Exp $

EAPI=5

KDE_LINGUAS="ar be bg ca ca@valencia cs da de el en_GB eo es et eu fr ga gl hi hne
hr is it ja km ku lt mai nb nds nl nn pa pl pt pt_BR ro ru se sk sv th tr uk vi
zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE graphviz dot graph file viewer"
HOMEPAGE="http://kde-apps.org/content/show.php?content=23999"
SRC_URI="https://api.opensuse.org/public/source/home:milianw:kdeapps/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	media-gfx/graphviz
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.38
"

PATCHES=( "${FILESDIR}/${P}-boost-1.50.patch" )
