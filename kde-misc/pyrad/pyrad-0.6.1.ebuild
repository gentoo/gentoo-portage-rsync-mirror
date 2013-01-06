# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pyrad/pyrad-0.6.1.ebuild,v 1.1 2012/12/05 08:49:13 kensington Exp $

EAPI=5
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[345] 3.*"

inherit distutils

MY_PN="pyRadKDE"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A wheel type command interface for KDE, heavily inspired by Kommando"
HOMEPAGE="http://bitbucket.org/ArneBab/pyrad"
SRC_URI="mirror://pypi/p/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND="kde-base/pykde4"
DEPEND="${RDEPEND}
	dev-python/setuptools"
