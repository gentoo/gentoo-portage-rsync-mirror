# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1-r1.ebuild,v 1.4 2012/08/27 18:00:02 armin76 Exp $

EAPI=2

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Adds multiple ssh keys to the ssh authentication agent"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/index_s.html#ssh-multiadd"
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="X"

DEPEND=""
RDEPEND="X? ( >=net-misc/x11-ssh-askpass-1.2.2 )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_compile(){
	:
}

src_install() {
	dobin ssh-multiadd || die
	doman ssh-multiadd.1
	dodoc README todo
}
