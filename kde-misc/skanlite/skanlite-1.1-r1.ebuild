# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/skanlite/skanlite-1.1-r1.ebuild,v 1.4 2014/12/12 21:11:14 mrueg Exp $

EAPI=5

KDE_LINGUAS="be bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl hr
hu ia is it ja km ko lt lv mai mr nb nds nl nn pa pl pt pt_BR ro ru sk sl sq sv
tr ug uk wa zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE image scanning application"
HOMEPAGE="http://www.kde.org/applications/graphics/skanlite/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="
	|| ( kde-apps/libksane:4 $(add_kdebase_dep libksane) )
	media-libs/libpng:0="
DEPEND="${RDEPEND}
	sys-devel/gettext"
