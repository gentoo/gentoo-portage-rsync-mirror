# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-generator_driver_update_disk/obs-service-generator_driver_update_disk-20110601.ebuild,v 1.2 2012/11/15 20:47:03 scarabeus Exp $

EAPI=5

inherit obs-service

SRC_URI+=" ${OBS_URI}/BSKiwiXML.pm"

IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/perl
"

src_install() {
	obs-service_src_install

	insinto /usr/lib/obs/service
	doins BSKiwiXML.pm
}
