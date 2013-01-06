# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-source_validator/obs-service-source_validator-0.2-r1.ebuild,v 1.1 2012/11/19 13:16:58 scarabeus Exp $

EAPI=5

inherit obs-service

# only one sanely packed service
SRC_URI="${OBS_URI}/${P}.tar.bz2"

KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/TimeDate"
RDEPEND="${DEPEND}"

src_unpack() {
	default
}

src_install() {
	# different folder and files in this module
	exeinto /usr/lib/obs/service
	doexe ${OBS_SERVICE_NAME}

	insinto /usr/lib/obs/service
	doins ${OBS_SERVICE_NAME}.service

	exeinto /usr/lib/obs/service/${OBS_SERVICE_NAME}s
	doexe [0-9]*
	exeinto /usr/lib/obs/service/${OBS_SERVICE_NAME}s/helpers/
	doexe helpers/*
}
