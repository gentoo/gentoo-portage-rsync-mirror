# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/deap/deap-1.0.0_rc1.ebuild,v 1.1 2013/07/08 06:59:32 slis Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1 versionator

MY_P=${PN}-$(delete_version_separator 3)

DESCRIPTION="Novel evolutionary computation framework"
HOMEPAGE="https://code.google.com/p/${PN}/"
SRC_URI="https://deap.googlecode.com/files/${MY_P}.tar.gz"

S="${WORKDIR}/$MY_P"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools"
