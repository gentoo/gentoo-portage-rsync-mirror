# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakeoil/snakeoil-9999.ebuild,v 1.6 2013/09/26 10:48:24 mgorny Exp $

EAPI=4
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1 git-2

DESCRIPTION="Miscellaneous python utility code."
HOMEPAGE="http://snakeoil.googlecode.com/"
EGIT_REPO_URI="https://code.google.com/p/snakeoil/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="!<sys-apps/pkgcore-0.4.7.8"
RDEPEND=${DEPEND}

python_configure_all() {
	# disable snakeoil 2to3 caching
	unset PY2TO3_CACHEDIR
}

python_test() {
	esetup.py test
}
