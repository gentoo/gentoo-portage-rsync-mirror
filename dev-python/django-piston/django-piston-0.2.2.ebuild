# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-piston/django-piston-0.2.2.ebuild,v 1.2 2012/04/17 15:00:34 mgorny Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

PYTHON_MODNAME="piston"

DESCRIPTION="A mini-framework for Django for creating RESTful APIs."
HOMEPAGE="http://bitbucket.org/jespern/django-piston/wiki/Home"
SRC_URI="mirror://bitbucket/jespern/django-piston/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${PN}"

src_install() {
	DOCS="AUTHORS.txt"

	distutils_src_install

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
