# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/complexity/complexity-1.1.ebuild,v 1.1 2013/11/03 18:27:12 jer Exp $

EAPI=5

DESCRIPTION="a tool designed for analyzing the complexity of C program functions"
HOMEPAGE="http://www.gnu.org/software/complexity/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"

RDEPEND=">=sys-devel/autogen-5.11.7"
DEPEND="
	${RDEPEND}
	sys-devel/libtool
"

DOCS=( AUTHORS ChangeLog NEWS )
