# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pyvo/pyvo-0.ebuild,v 1.3 2014/02/05 23:46:59 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit python-r1

DESCRIPTION="Virtual for python VOTable"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="|| (
		>=dev-python/vo-0.8[${PYTHON_USEDEP}]
		<dev-python/astropy-0.3[${PYTHON_USEDEP}]
	)"
