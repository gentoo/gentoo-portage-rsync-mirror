# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elasticsearch-py/elasticsearch-py-1.4.0.ebuild,v 1.3 2015/03/08 23:46:09 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="official Python low-level client for Elasticsearch"
HOMEPAGE="http://elasticsearch-py.rtfd.org/"
SRC_URI="https://github.com/elasticsearch/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips x86"
IUSE=""

DEPEND="dev-python/urllib3[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
