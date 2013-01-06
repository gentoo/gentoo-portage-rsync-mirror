# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/skanlite/skanlite-0.9.ebuild,v 1.3 2012/11/14 20:17:47 johu Exp $

EAPI=4

KDE_LINGUAS="be bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl hr
hu is it ja km ko lt lv mai nb nds nl nn pa pl pt pt_BR ro ru sk sl sq sv tr ug
uk wa zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE image scanning application"
HOMEPAGE="http://www.kde.org/applications/graphics/skanlite/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep libksane)"
RDEPEND=${DEPEND}
