# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jenkins-bin/jenkins-bin-1.605.ebuild,v 1.1 2015/03/18 12:24:35 mrueg Exp $

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

RDEPEND="media-fonts/dejavu
	media-libs/freetype
	!dev-util/jenkins-bin:lts
	virtual/jre"

S=${WORKDIR}

JENKINS_DIR=/var/lib/jenkins

pkg_setup() {
	enewgroup jenkins
	enewuser jenkins -1 -1 ${JENKINS_DIR} jenkins
}

src_install() {
	keepdir /var/log/jenkins ${JENKINS_DIR}/backup ${JENKINS_DIR}/home

	insinto /opt/jenkins
	newins "${DISTDIR}"/${P}.war ${PN/-bin/}.war

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN/-bin/}

	newinitd "${FILESDIR}"/${PN}.init2 jenkins
	newconfd "${FILESDIR}"/${PN}.confd jenkins

	fowners jenkins:jenkins /var/log/jenkins ${JENKINS_DIR} ${JENKINS_DIR}/home ${JENKINS_DIR}/backup
}
