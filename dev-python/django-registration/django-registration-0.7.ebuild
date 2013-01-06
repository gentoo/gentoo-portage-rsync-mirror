# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-registration/django-registration-0.7.ebuild,v 1.1 2011/04/08 04:00:25 jmbsvicetto Exp $

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
