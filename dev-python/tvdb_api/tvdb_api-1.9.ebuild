# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tvdb_api/tvdb_api-1.9.ebuild,v 1.1 2014/07/05 14:59:47 thev00d00 Exp $

EAPI=5

PYTHON_COMPAT="python2_7"
inherit distutils-r1 vcs-snapshot

SRC_URI="https://github.com/dbr/${PN}/tarball/${PV} -> ${P}.tar.gz"
DESCRIPTION="Python interface to thetvdb.com API"
HOMEPAGE="http://github.com/dbr/tvdb_api"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="public-domain"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=""
