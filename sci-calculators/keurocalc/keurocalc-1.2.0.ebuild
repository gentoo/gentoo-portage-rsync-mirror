# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/keurocalc/keurocalc-1.2.0.ebuild,v 1.1 2012/03/01 12:12:24 johu Exp $

EAPI=4
KDE_LINGUAS="ar bg bs ca ca@valencia cs da de el en_GB es et fr ga gl hu it ja
ka ko nb nds nl pl pt pt_BR ru sk sr sr@Latn sv ta tr uk zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A universal currency converter and calculator"
HOMEPAGE="http://opensource.bureau-cornavin.com/keurocalc/index.html"
SRC_URI="http://opensource.bureau-cornavin.com/keurocalc/sources/${P}.tgz"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS=( AUTHORS ChangeLog README TODO )
