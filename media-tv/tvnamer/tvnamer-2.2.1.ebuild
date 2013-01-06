# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvnamer/tvnamer-2.2.1.ebuild,v 1.1 2012/10/23 19:57:58 thev00d00 Exp $

EAPI=4

inherit distutils

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
