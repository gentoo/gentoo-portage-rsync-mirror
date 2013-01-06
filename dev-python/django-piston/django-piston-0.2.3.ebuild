# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-piston/django-piston-0.2.3.ebuild,v 1.1 2011/12/11 07:11:27 floppym Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

PYTHON_MODNAME="piston"

DESCRIPTION="A mini-framework for Django for creating RESTful APIs."
HOMEPAGE="http://bitbucket.org/jespern/django-piston/wiki/Home"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools"
