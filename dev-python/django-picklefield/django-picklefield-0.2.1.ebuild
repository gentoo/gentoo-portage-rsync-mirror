# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-picklefield/django-picklefield-0.2.1.ebuild,v 1.1 2012/05/30 06:32:59 iksaif Exp $

EAPI="4"

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Implementation of a pickled object field for django"
HOMEPAGE="http://github.com/shrubberysoft/django-picklefield"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/django-1.1.1"
DEPEND="${RDEPEND}
	dev-python/setuptools"
