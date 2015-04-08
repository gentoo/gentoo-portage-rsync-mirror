# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/easydiff/easydiff-0.3.1_pre20061115.ebuild,v 1.6 2014/08/10 21:19:40 slyfox Exp $

inherit gnustep-2

DESCRIPTION="GNUstep app that lets you easily see the differences between two text files"
HOMEPAGE="http://www.collaboration-world.com/easydiff/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-vcs/subversion"
