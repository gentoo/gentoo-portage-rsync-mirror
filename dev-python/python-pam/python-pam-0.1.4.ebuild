# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-pam/python-pam-0.1.4.ebuild,v 1.4 2014/08/10 21:19:34 slyfox Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

MY_PN=${PN#python-}
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="A python interface to the PAM library on linux using ctypes"
HOMEPAGE="http://atlee.ca/software/pam"
SRC_URI="mirror://pypi/p/${MY_PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
