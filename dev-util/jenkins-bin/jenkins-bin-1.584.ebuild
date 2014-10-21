# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jenkins-bin/jenkins-bin-1.584.ebuild,v 1.2 2014/10/20 23:18:28 mrueg Exp $

EAPI=5

inherit user

DESCRIPTION="Extensible continuous integration server"
HOMEPAGE="http://jenkins-ci.org/"
LICENSE="MIT"
SRC_URI="http://mirrors.jenkins-ci.org/war/${PV}/${PN/-bin/}.war -> ${P}.war"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-fonts/dejavu"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.5"

S=${WORKDIR}

pkg_setup() {
	enewgroup jenkins
	enewuser jenkins -1 /bin/bash /var/lib/jenkins jenkins
}

src_install() {
	keepdir /var/run/jenkins /var/log/jenkins
	keepdir /var/lib/jenkins/home /var/lib/jenkins/backup

	insinto /opt/jenkins
	newins "${DISTDIR}"/${P}.war ${PN/-bin/}.war

	newinitd "${FILESDIR}"/${PN}.init jenkins
	newconfd "${FILESDIR}"/${PN}.confd jenkins

	fowners jenkins:jenkins /var/run/jenkins /var/log/jenkins /var/lib/jenkins /var/lib/jenkins/home /var/lib/jenkins/backup
}
