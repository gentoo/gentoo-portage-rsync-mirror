# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-recaptcha/django-recaptcha-0.0.5.ebuild,v 1.1 2012/10/25 10:55:11 iksaif Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="captcha"

inherit distutils

DESCRIPTION="Django recaptcha form field/widget app"
HOMEPAGE="http://github.com/praekelt/django-recaptcha http://pypi.python.org/pypi/django-recaptcha"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-python/setuptools"

# Test not supported, missing dependency
# test? ( >=dev-python/django-setuptest-0.0.6 )
