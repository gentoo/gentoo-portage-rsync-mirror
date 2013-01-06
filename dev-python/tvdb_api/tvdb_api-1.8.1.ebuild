# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tvdb_api/tvdb_api-1.8.1.ebuild,v 1.1 2012/10/23 19:42:53 thev00d00 Exp $

EAPI=4

inherit distutils vcs-snapshot

SRC_URI="https://github.com/dbr/${PN}/tarball/${PV} -> ${P}.tar.gz"
DESCRIPTION="Python interface to thetvdb.com API"
HOMEPAGE="http://github.com/dbr/tvdb_api"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="public-domain"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=""
