# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/xjobs/xjobs-20140125.ebuild,v 1.1 2014/10/19 00:19:49 mjo Exp $

EAPI=5

DESCRIPTION="Reads commands line by line and executes them in parallel"
HOMEPAGE="http://www.maier-komor.de/${PN}.html"
SRC_URI="http://www.maier-komor.de/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/flex"
RDEPEND=""
