# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstartperf/kstartperf-4.10.1.ebuild,v 1.3 2013/03/31 16:47:04 ago Exp $

EAPI=5

if [[ ${PV} == *9999 ]]; then
	KMNAME="kde-dev-utils"
else
	KMNAME="kdesdk"
	KMMODULE="kde-dev-utils/${PN}"
fi
inherit kde4-meta

DESCRIPTION="Measures starting performance of applications"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
