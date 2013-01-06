# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.1_alpha6-r1.ebuild,v 1.5 2012/09/07 12:45:24 lordvan Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="${P/_alpha/a}"

DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/bsddb3
	dev-python/lockfile"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

# Some scripts import objects from other scripts.
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

src_install() {
	distutils_src_install

	dodoc *.txt
	insinto /usr/share/doc/${PF}/contrib
	doins contrib/*
	insinto /usr/share/doc/${PF}/utilities
	doins utilities/*
	insinto /usr/share/doc/${PF}/testtools
	doins testtools/*

	newinitd "${FILESDIR}/spambayespop3proxy.rc" spambayespop3proxy

	insinto /etc
	doins "${FILESDIR}/bayescustomize.ini"

	keepdir /var/lib/spambayes
}
