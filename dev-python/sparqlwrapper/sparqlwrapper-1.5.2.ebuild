# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sparqlwrapper/sparqlwrapper-1.5.2.ebuild,v 1.2 2014/04/14 08:06:05 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

MY_P="SPARQLWrapper"
DESCRIPTION="A wrapper around a SPARQL service"
HOMEPAGE="http://sparql-wrapper.sourceforge.net/"
SRC_URI="mirror://pypi/S/${MY_P}/${MY_P}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/rdflib-2.4.2[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}-${PV}"
