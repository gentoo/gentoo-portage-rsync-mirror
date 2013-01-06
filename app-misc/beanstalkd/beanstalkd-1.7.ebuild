# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beanstalkd/beanstalkd-1.7.ebuild,v 1.2 2012/10/07 04:14:16 mr_bones_ Exp $

EAPI="4"

PYTHON_DEPEND="test? 2"

inherit eutils python user

DESCRIPTION="A fast, distributed, in-memory workqueue service"
HOMEPAGE="http://xph.us/software/beanstalkd/"
SRC_URI="mirror://github/kr/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x64-macos ~x86-macos"

RDEPEND=""
DEPEND=""

IUSE="test"

pkg_setup() {
	enewuser beanstalk -1 -1 /var/lib/beanstalkd daemon
	python_set_active_version 2
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "compile failed"
}

src_install() {
	dobin beanstalkd

	DATADIR=/var/lib/${PN}
	dodir ${DATADIR}
	fowners beanstalk:daemon ${DATADIR}

	doman doc/"${PN}".1

	dodoc README NEWS.md doc/*.txt

	newconfd "${FILESDIR}/conf-1.4.2" beanstalkd
	newinitd "${FILESDIR}/init-${PV}" beanstalkd
}
