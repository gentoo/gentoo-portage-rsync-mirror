# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.1_beta1.ebuild,v 1.1 2014/07/24 14:54:34 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_P="${P/_beta/b}"

DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="
	dev-python/bsddb3[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	distutils-r1_python_install_all

	dodoc -r *.txt contrib utilities testtools

	newinitd "${FILESDIR}"/spambayespop3proxy.rc spambayespop3proxy

	insinto /etc
	doins "${FILESDIR}"/bayescustomize.ini

	keepdir /var/lib/spambayes
}
