# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kraft/kraft-0.50.ebuild,v 1.2 2013/03/23 14:25:42 kensington Exp $

EAPI=5
inherit kde4-base

DESCRIPTION="Software for operating a small business, helping create documents such as offers and invoices"
HOMEPAGE="http://www.volle-kraft-voraus.de/"
SRC_URI="mirror://sourceforge/kraft/${P}.tar.bz2"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-cpp/ctemplate
	$(add_kdebase_dep kdepimlibs)
	>=dev-qt/qtsql-${QT_MINIMAL}:4[mysql,sqlite]
"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS Changes.txt README Releasenotes.txt TODO)
