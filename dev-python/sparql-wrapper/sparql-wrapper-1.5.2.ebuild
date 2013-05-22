# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sparql-wrapper/sparql-wrapper-1.5.2.ebuild,v 1.2 2013/05/22 10:04:06 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

MY_PN=SPARQLWrapper
DESCRIPTION="Wrapper around a SPARQL service"
HOMEPAGE="http://pypi.python.org/pypi/${MY_PN}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-python/rdflib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}
