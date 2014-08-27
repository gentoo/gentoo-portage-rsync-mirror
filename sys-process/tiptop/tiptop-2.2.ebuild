# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/tiptop/tiptop-2.2.ebuild,v 1.2 2014/08/27 17:14:30 ryao Exp $

EAPI=5

DESCRIPTION="top for performance counters"
HOMEPAGE="http://tiptop.gforge.inria.fr/"
SRC_URI="http://${PN}.gforge.inria.fr/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	dev-libs/libxml2"
DEPEND="${RDEPEND}"
