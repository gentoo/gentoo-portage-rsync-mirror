# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-download_files/obs-service-download_files-20120824.ebuild,v 1.2 2012/11/15 19:57:27 scarabeus Exp $

EAPI=5

inherit obs-service

IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}
	net-misc/wget
"
