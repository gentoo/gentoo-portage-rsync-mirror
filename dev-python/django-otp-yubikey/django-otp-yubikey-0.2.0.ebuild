# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-otp-yubikey/django-otp-yubikey-0.2.0.ebuild,v 1.2 2015/04/08 08:05:15 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit eutils distutils-r1

DESCRIPTION="django-otp plugin that verifies YubiKey OTP tokens"
HOMEPAGE="https://bitbucket.org/psagers/django-otp"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

DEPEND="dev-python/django-otp[${PYTHON_USEDEP}]
		dev-python/yubiotp[${PYTHON_USEDEP}]"
