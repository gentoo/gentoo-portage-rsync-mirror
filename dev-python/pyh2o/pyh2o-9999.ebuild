# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyh2o/pyh2o-9999.ebuild,v 1.2 2012/12/17 19:58:35 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_8,1_9} )

inherit distutils-r1

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-2
#endif

DESCRIPTION="Library of routines for IF97 water & steam properties"
HOMEPAGE="https://bitbucket.org/mgorny/libh2o/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#if LIVE
KEYWORDS=
SRC_URI=
#endif
