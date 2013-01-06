# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-recompress/obs-service-recompress-20120301.ebuild,v 1.2 2012/11/15 20:51:28 scarabeus Exp $

EAPI=5

inherit obs-service

IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/bzip2
	app-arch/gzip
	app-arch/xz-utils
"
