# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kraft/kraft-0.54.ebuild,v 1.1 2014/05/17 14:40:18 creffett Exp $

EAPI=5

KDE_LINGUAS="bg bs cs da de en_GB eo es et fi fr ga gl hu it ja lt mai mr nds
nl pl pt pt_BR sk sv tr ug uk zh_CN"
inherit kde4-base

DESCRIPTION="Software for operating a small business, helping create documents such as offers and invoices"
HOMEPAGE="http://www.volle-kraft-voraus.de/"
SRC_URI="mirror://sourceforge/kraft/${P}.tar.bz2"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	dev-cpp/ctemplate
	dev-qt/qtsql:4[mysql,sqlite]
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS Changes.txt README Releasenotes.txt TODO)
