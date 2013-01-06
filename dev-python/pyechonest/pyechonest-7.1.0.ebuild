# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyechonest/pyechonest-7.1.0.ebuild,v 1.1 2013/01/02 23:16:27 sochotnicky Exp $

EAPI=4

inherit distutils

DESCRIPTION="Python interface to The Echo Nest APIs"
HOMEPAGE="http://echonest.github.com/pyechonest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
