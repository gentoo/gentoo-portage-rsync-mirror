# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvnamer/tvnamer-2.3.ebuild,v 1.1 2014/06/29 16:50:26 thev00d00 Exp $

EAPI=5

PYTHON_COMPAT="python2_7"
inherit distutils-r1

SRC_URI="mirror://pypi/t/${PN}/${P}.tar.gz"
DESCRIPTION="Automatic TV episode file renamer, data from thetvdb.com"
HOMEPAGE="http://github.com/dbr/tvnamer"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="public-domain"
IUSE=""
RDEPEND="dev-python/tvdb_api"
DEPEND="${DEPEND}
	dev-python/setuptools
"
