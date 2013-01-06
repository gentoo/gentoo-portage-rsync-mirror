# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gmines/gmines-0.1-r2.ebuild,v 1.5 2012/02/14 21:46:17 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/gm/GM}

DESCRIPTION="The well-known minesweeper game."
HOMEPAGE="http://www.gnustep.it/marko/GMines/index.html"
SRC_URI="http://www.gnustep.it/marko/GMines/${PN/gm/GM}.tgz"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
