# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lib_users/lib_users-0.6.ebuild,v 1.1 2013/05/31 12:01:44 klausman Exp $
EAPI=5
PYTHON_COMPAT=( python2_7 python3_2 )

inherit python-r1

DESCRIPTION="Goes through /proc and finds all cases of libraries being mapped
but marked as deleted"
HOMEPAGE="http://schwarzvogel.de/software-misc.shtml"
SRC_URI="http://schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="test? ( dev-python/nose )"
RDEPEND=""

src_install() {
	newbin lib_users.py lib_users
	dodoc README TODO
}
