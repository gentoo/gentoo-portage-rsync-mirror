# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/projectcenter/projectcenter-0.6.2.ebuild,v 1.1 2014/10/27 10:03:56 voyageur Exp $

EAPI=5
inherit gnustep-2

MY_P=${P/projectc/ProjectC}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An IDE for GNUstep"
HOMEPAGE="http://www.gnustep.org/experience/ProjectCenter.html"
SRC_URI="http://ftpmain.gnustep.org/pub/gnustep/dev-apps/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=sys-devel/gdb-6.0"
