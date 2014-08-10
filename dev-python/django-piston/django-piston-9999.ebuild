# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-piston/django-piston-9999.ebuild,v 1.2 2014/08/10 21:09:29 slyfox Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils mercurial

PYTHON_MODNAME="piston"

DESCRIPTION="A mini-framework for Django for creating RESTful APIs"
HOMEPAGE="http://bitbucket.org/jespern/django-piston/wiki/Home"
EHG_REPO_URI="http://bitbucket.org/jespern/django-piston/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
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
