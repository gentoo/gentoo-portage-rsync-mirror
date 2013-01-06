# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-registration/django-registration-0.8.ebuild,v 1.1 2012/04/08 19:20:59 floppym Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="registration"

inherit distutils

DESCRIPTION="An extensible user-registration application for Django"
HOMEPAGE="http://www.bitbucket.org/ubernostrum/django-registration/wiki/ http://pypi.python.org/pypi/django-registration"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/django"
RDEPEND="${DEPEND}"
