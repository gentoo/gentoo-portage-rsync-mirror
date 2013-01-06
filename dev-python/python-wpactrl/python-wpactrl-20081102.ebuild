# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-wpactrl/python-wpactrl-20081102.ebuild,v 1.10 2012/02/20 15:09:39 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="A Python extension for wpa_supplicant/hostapd control interface access"
HOMEPAGE="http://projects.otaku42.de/wiki/PythonWpaCtrl"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND=""
