# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lib_users/lib_users-0.6.ebuild,v 1.7 2013/08/18 13:28:42 ago Exp $

EAPI=5

inherit python

DESCRIPTION="Checks /proc for libraries being mapped but marked as deleted"
HOMEPAGE="http://schwarzvogel.de/software-misc.shtml"
SRC_URI="http://schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="test? ( dev-python/nose )"
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_test() {
	python_execute_nosetests -P .
}

src_install() {
	newbin lib_users.py lib_users
	dodoc README TODO
}
