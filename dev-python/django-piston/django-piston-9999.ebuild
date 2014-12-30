# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-piston/django-piston-9999.ebuild,v 1.3 2014/12/30 04:50:14 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 mercurial

PYTHON_MODNAME="piston"

DESCRIPTION="A mini-framework for Django for creating RESTful APIs"
HOMEPAGE="http://bitbucket.org/jespern/django-piston/wiki/Home"
EHG_REPO_URI="http://bitbucket.org/jespern/django-piston/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}"
