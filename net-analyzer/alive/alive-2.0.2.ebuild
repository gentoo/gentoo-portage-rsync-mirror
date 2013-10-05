# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/alive/alive-2.0.2.ebuild,v 1.1 2013/10/05 16:29:13 jer Exp $

EAPI=5

DESCRIPTION="a periodic ping program"
HOMEPAGE="http://www.gnu.org/software/alive/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND="
	dev-scheme/guile
	net-misc/iputils
"
