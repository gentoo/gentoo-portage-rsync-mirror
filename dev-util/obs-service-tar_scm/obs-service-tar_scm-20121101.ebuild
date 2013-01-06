# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-tar_scm/obs-service-tar_scm-20121101.ebuild,v 1.2 2012/11/15 21:14:48 scarabeus Exp $

EAPI=5

inherit obs-service

SRC_URI+=" ${OBS_URI}/${OBS_SERVICE_NAME}.rc -> ${OBS_SERVICE_NAME}-${PV}.rc"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-vcs/bzr
	dev-vcs/git
	dev-vcs/mercurial
	dev-vcs/subversion
"

src_install() {
	obs-service_src_install

	insinto /etc/obs/services
	newins ${OBS_SERVICE_NAME}-${PV}.rc ${OBS_SERVICE_NAME}
}
