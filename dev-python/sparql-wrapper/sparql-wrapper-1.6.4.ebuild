# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sparql-wrapper/sparql-wrapper-1.6.4.ebuild,v 1.5 2015/03/08 23:59:22 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

MY_PN=SPARQLWrapper
DESCRIPTION="Wrapper around a SPARQL service"
HOMEPAGE="http://pypi.python.org/pypi/${MY_PN}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="W3C"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/rdflib-2.4.2[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_PN}-${PV}
